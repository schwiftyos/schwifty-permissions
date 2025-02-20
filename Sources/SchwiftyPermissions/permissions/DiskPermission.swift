//
//  DiskPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

/// Disk permissions for a program.
public struct DiskPermission : SchwiftyPermission {
    public private(set) var status:PermissionStatus

    /// Absolute paths the program can read.
    public private(set) var pathReadWhitelist:Set<String>

    /// Absolute paths the program cannot read.
    public private(set) var pathReadBlacklist:Set<String>

    /// Absolute paths the program can write to.
    public private(set) var pathWriteWhitelist:Set<String>

    /// Absolute paths the program cannot write to.
    public private(set) var pathWriteBlacklist:Set<String>

    @usableFromInline
    var permissions:UInt8
}

// MARK: Default
extension DiskPermission {
    public static let `default`:Self = Self(
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
    public enum Action : Sendable {
        case read(String)
        case write(String)
        // TODO: support move?
    }

    @inlinable
    public func canPerform(state: ProgramState, action: Action) -> Bool {
        guard status.isAllowed(for: state) else { return false }
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
    /// Whether or not a program can read from the disk.
    @inlinable
    public var canRead : Bool {
        permissions & 0b1 != 0
    }
}

// MARK: Write
extension DiskPermission {
    /// Whether or not a program can write to the disk.
    @inlinable
    public var canWrite : Bool {
        permissions & 0b01 != 0
    }
}