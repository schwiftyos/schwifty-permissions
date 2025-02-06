//
//  ApplicationPermissions.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// Permissions for an application.
public struct ApplicationPermissions : Sendable {
    var internetDownload:PermissionSnapshot<InternetData>! = nil
    var diskRead:PermissionSnapshot<DiskData>! = nil

    public mutating func snapshot(
        for permission: SchwiftyPermission,
        onBehalfOf program: UInt64
    ) async -> AnyPermissionSnapshot {
        switch permission {
        case .internetDownload:
            if internetDownload == nil { internetDownload = await requestPermission(permission, onBehalfOf: program) }
            return internetDownload
        case .diskRead:
            if diskRead == nil { diskRead = await requestPermission(permission, onBehalfOf: program) }
            return diskRead
        default:
            return PermissionSnapshot(status: .never, data: Empty())
        }
    }

    public mutating func status(
        for permission: SchwiftyPermission,
        onBehalfOf program: UInt64
    ) async -> PermissionStatus {
        return await snapshot(for: permission, onBehalfOf: program).status
    }

    mutating func requestPermission<T: PermissionSnapshotData>(
        _ permission: SchwiftyPermission,
        onBehalfOf program: UInt64
    ) async -> PermissionSnapshot<T> {
        if let result:UInt8 = await promptPermission(permission, requestor: program), let p:PermissionStatus = PermissionStatus(rawValue: result) {
            // TODO: finish
            return PermissionSnapshot(status: p, data: T())
        }
        return PermissionSnapshot(status: .never, data: T())
    }


    /// - Returns: The selected Permission Status code.
    func promptPermission(
        _ permission: SchwiftyPermission,
        requestor: UInt64
    ) async -> UInt8? {
        // TODO: add UI prompt and completion handler callback
        return nil
    }
}