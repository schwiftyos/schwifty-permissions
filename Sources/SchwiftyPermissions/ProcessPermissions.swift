
/// Permissions for a process.
public final class ProcessPermissions : @unchecked Sendable {
    var _calendar:CalendarPermission! = nil
    var _disk:DiskPermission! = nil
    var _location:LocationPermission! = nil
    var _manipulation:ManipulatePermission! = nil
    var _network:NetworkPermission! = nil
    var _notifications:NotificationPermission! = nil
    var _wallet:WalletPermission! = nil

    @usableFromInline
    init() {
    }
}

// MARK: Program
extension ProcessPermissions {
    @inlinable
    public func request<T: SchwiftyPermission>(
        _ permission: SchwiftyPermissionType,
        for program: Program,
        reason: String = "Unspecified"
    ) -> Result<T, PermissionError> {
        let perm:T = getOrLoad(permission, for: program)
        guard program.state.allowsPermissionStatus(perm.status) else {
            return .failure(.operationDenied)
        }
        switch perm.status {
        case .uponRequest:
            // TODO: add UI prompt (if necessary)
            break
        default:
            break
        }
        return .success(perm)
    }

    @usableFromInline
    func getOrLoad<T: SchwiftyPermission>(
        _ permission: SchwiftyPermissionType,
        for program: Program
    ) -> T {
        switch permission {
        case .calendar:
            if _calendar == nil { _calendar = .loadSettings(for: program) }
            return _calendar as! T
        case .disk:
            if _disk == nil { _disk = .loadSettings(for: program) }
            return _disk as! T
        case .location:
            if _location == nil { _location = .loadSettings(for: program) }
            return _location as! T
        case .manipulation:
            if _manipulation == nil { _manipulation = .loadSettings(for: program) }
            return _manipulation as! T
        case .network:
            if _network == nil { _network = .loadSettings(for: program) }
            return _network as! T
        case .notification:
            if _notifications == nil { _notifications = .loadSettings(for: program) }
            return _notifications as! T
        case .wallet:
            if _wallet == nil { _wallet = .loadSettings(for: program) }
            return _wallet as! T
        }
    }
}