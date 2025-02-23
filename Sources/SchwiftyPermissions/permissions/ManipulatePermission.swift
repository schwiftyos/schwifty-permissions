//
//  ManipulatePermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

/// Manipulation permissions for a program.
public struct ManipulatePermission : SchwiftyPermission {
    public static let permissionType:SchwiftyPermissionType = .manipulation

    public private(set) var status:PermissionStatus

    /// - Usage: [`Process ID` : `Manipulation Permissions for the process`]
    var processes:[SchwiftyPermissions.Program.ProcessID:Process]
    
    /// - Usage: [`Program Application ID` : `Manipulation Permissions for the program`]
    var programs:[SchwiftyPermissions.Program.ApplicationID:Process]
}

// MARK: Default
extension ManipulatePermission {
    public static let `default`:Self = Self(
        status: .never,
        processes: [:],
        programs: [:]
    )
}

// MARK: Process
extension ManipulatePermission {
    /// Permissions for a process that can be manipulated.
    public struct Process : Hashable, Sendable {
        @usableFromInline
        var permissions:Permission.RawValue
    }
}

extension ManipulatePermission.Process {
    public enum Permission : UInt8, Sendable {
        /// Whether or not user interaction is required if the
        /// manipulating process wants to change permissions
        /// of a process it has access to manipulate.
        case changePermissionsWithoutUserInteraction = 1
    }

    @inlinable
    public func hasPermission(to permission: Permission) -> Bool {
        return permissions & permission.rawValue != 0
    }
}