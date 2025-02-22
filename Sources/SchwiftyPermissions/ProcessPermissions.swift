//
//  ProcessPermissions.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// Permissions for a process.
public struct ProcessPermissions : Sendable {
    var state:ProgramState

    var disk:DiskPermission! = nil
    var location:LocationPermission! = nil
    var manipulation:ManipulatePermission! = nil
    var network:NetworkPermission! = nil
    var notifications:NotificationPermission! = nil
    var wallet:WalletPermission! = nil

    /*public mutating func get(
        for permission: SchwiftyPermission,
        onBehalfOf program: Program,
        reason: String
    ) async -> AnyPermissionSnapshot {
        switch permission {
        default:
            return PermissionSnapshot(status: .never, data: Empty())
        }
    }

    public mutating func status(
        for permission: SchwiftyPermission,
        onBehalfOf program: Program,
        reason: String
    ) async -> PermissionStatus {
        return await get(for: permission, onBehalfOf: program, reason: reason).status
    }

    mutating func requestPermission<T: PermissionSnapshotData>(
        _ permission: SchwiftyPermission,
        onBehalfOf program: Program,
        reason: String
    ) async -> PermissionSnapshot<T> {
        if let result:UInt8 = await promptPermission(permission, requestor: Program, reason: reason), let p:PermissionStatus = PermissionStatus(rawValue: result) {
            // TODO: finish
            return PermissionSnapshot(status: p, data: T())
        }
        return PermissionSnapshot(status: .never, data: T())
    }*/


    /// - Returns: The selected Permission Status code.
    func promptPermission(
        _ permission: SchwiftyPermission,
        requestor: Program,
        reason: String
    ) async -> UInt8? {
        // TODO: add UI prompt and completion handler callback
        return nil
    }
}