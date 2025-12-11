
/// Disk permissions for a process.
public struct DiskPermission: SchwiftyPermission {
    public static let permissionType = SchwiftyPermissionType.disk

    public private(set) var status:PermissionStatus

    /// Absolute paths the process can read.
    public private(set) var pathReadWhitelist:Set<String>

    /// Absolute paths the process cannot read.
    public private(set) var pathReadBlacklist:Set<String>

    /// Absolute paths the process can write to.
    public private(set) var pathWriteWhitelist:Set<String>

    /// Absolute paths the process cannot write to.
    public private(set) var pathWriteBlacklist:Set<String>

    var permissions:Flag.RawValue
}

// MARK: Flag
extension DiskPermission {
    enum Flag: UInt8, Sendable {
        case read  = 1
        case write = 2

        func isEnabled(_ permissions: RawValue) -> Bool {
            permissions & rawValue > 0
        }
    }
}

// MARK: Default
extension DiskPermission {
    public static let `default` = Self(
        status: .uponRequest,
        pathReadWhitelist: [],
        pathReadBlacklist: [],
        pathWriteWhitelist: [],
        pathWriteBlacklist: [],
        permissions: .max
    )
}

// MARK: Action
extension DiskPermission {
    public enum Action: Sendable {
        case read(String)
        case write(String)
        // TODO: support move?
    }

    public func canPerform(action: Action, state: ProgramState) -> Bool {
        guard state.allowsPermissionStatus(status) else { return false }
        switch action {
        case .read(let path):
            return canRead && (pathReadWhitelist.isEmpty || pathReadWhitelist.contains(path)) && !pathReadBlacklist.contains(path)
        case .write(let path):
            return canWrite && (pathWriteWhitelist.isEmpty || pathWriteWhitelist.contains(path)) && !pathWriteBlacklist.contains(path)
        @unknown default:
            return false
        }
    }
}

// MARK: Read
extension DiskPermission {
    /// Whether or not a process can read from the disk.
    public var canRead: Bool {
        Flag.read.isEnabled(permissions)
    }
}

// MARK: Write
extension DiskPermission {
    /// Whether or not a process can write to the disk.
    public var canWrite: Bool {
        Flag.write.isEnabled(permissions)
    }
}

// MARK: Modifications
extension DiskPermission {
    /// Mutates `permissions` to reflect its new read status.
    mutating func setCanRead(_ newValue: Bool) {
        permissions = newValue ? permissions | Flag.read.rawValue : permissions & ~Flag.read.rawValue
    }

    /// Mutates `permissions` to reflect its new write status.
    mutating func setCanWrite(_ newValue: Bool) {
        permissions = newValue ? permissions | Flag.write.rawValue : permissions & ~Flag.write.rawValue
    }
}