//
//  SchwiftyPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

/// Any permission that restricts the functionality of a process.
public protocol SchwiftyPermission : Sendable {
    /// Default values for this permission.
    static var `default` : Self { get }

    static var permissionType : SchwiftyPermissionType { get }

    /// - Returns: Permission settings for the program (read from disk).
    static func loadSettings(for program: Program) -> Self


    /// Current status of a permission.
    var status : PermissionStatus { get }
}

extension SchwiftyPermission {
    @inlinable
    public static func loadSettings(for program: Program) -> Self {
        // TODO: return existing settings for application id
        return .default
    }
}