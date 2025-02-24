//
//  ProcessPermissions.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// Permissions for a process.
public final class ProcessPermissions : @unchecked Sendable {
    var calendar:CalendarPermission! = nil
    var disk:DiskPermission! = nil
    var location:LocationPermission! = nil
    var manipulation:ManipulatePermission! = nil
    var network:NetworkPermission! = nil
    var notifications:NotificationPermission! = nil
    var wallet:WalletPermission! = nil

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
        reason: String
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
            if calendar == nil { calendar = .loadSettings(for: program) }
            return calendar as! T
        case .disk:
            if disk == nil { disk = .loadSettings(for: program) }
            return disk as! T
        case .location:
            if location == nil { location = .loadSettings(for: program) }
            return location as! T
        case .manipulation:
            if manipulation == nil { manipulation = .loadSettings(for: program) }
            return manipulation as! T
        case .network:
            if network == nil { network = .loadSettings(for: program) }
            return network as! T
        case .notification:
            if notifications == nil { notifications = .loadSettings(for: program) }
            return notifications as! T
        case .wallet:
            if wallet == nil { wallet = .loadSettings(for: program) }
            return wallet as! T
        }
    }
}