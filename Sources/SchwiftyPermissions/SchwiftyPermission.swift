//
//  SchwiftyPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

public protocol SchwiftyPermission : Sendable {
    /// Default values for this permission.
    static var `default` : Self { get }

    static var permissionType : SchwiftyPermissionType { get }

    /// - Returns: Permission settings for the program.
    static func settings(for program: Program) -> Self


    /// Current status of a permission.
    var status : PermissionStatus { get }
}

extension SchwiftyPermission {
    @inlinable
    public static func settings(for program: Program) -> Self {
        // TODO: return existing settings for application id
        return .default
    }
}