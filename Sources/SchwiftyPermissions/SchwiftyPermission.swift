// This source file is part of the Schwifty Permissions open source project
//
// Copyright (c) 2025 Evan Anderson and the Schwifty Permissions project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://github.com/schwiftyos/schwifty-permissions/LICENSE.txt for license information
// See https://github.com/schwiftyos/schwifty-permissions/CONTRIBUTORS.txt for the list of Schwifty Permissions project authors

/// Any permission that restricts the functionality of a process.
public protocol SchwiftyPermission : Sendable {
    /// Default values for this permission.
    static var `default` : Self { get }

    static var permissionType : SchwiftyPermissionType { get }

    /// - Returns: Permission settings for the program (read from disk).
    static func loadSettings(for program: Program) -> Self

    /// - Returns: Permission settings for the system (read from disk).
    static func loadSystemSettings() -> Self


    /// Current status of a permission.
    var status : PermissionStatus { get }
}

extension SchwiftyPermission {
    @inlinable
    public static func loadSettings(for program: Program) -> Self {
        // TODO: return existing settings for application id
        return .default
    }

    @inlinable
    public static func loadSystemSettings() -> Self {
        // TODO: return existing settings from disk
        return .default
    }
}