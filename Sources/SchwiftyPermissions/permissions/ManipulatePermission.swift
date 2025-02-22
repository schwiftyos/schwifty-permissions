//
//  ManipulatePermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

/// Manipulation permissions for a program.
public struct ManipulatePermission : SchwiftyPermission {
    public private(set) var status:PermissionStatus

    /// - Usage: [`Program`]
    var programs:[Program]
}

// MARK: Default
extension ManipulatePermission {
    public static let `default`:Self = Self(
        status: .never,
        programs: []
    )
}

// MARK: Program
extension ManipulatePermission {
    /// Permissions for a program that can be manipulated.
    public struct Program : Hashable, Sendable {
        @usableFromInline
        var permissions:UInt8
    }
}

extension ManipulatePermission.Program {
    /// Whether or not the program with program manipulation permission can change permissions
    /// of a program it has access to manipulate.
    @inlinable
    public var canChangePermissions : Bool {
        permissions & 0b1 != 0
    }
    
    /// Whether or not the program with program manipulation permission can change permissions
    /// of a program it has access to manipulate without user interaction.
    @inlinable
    public var canChangePermissionsWithoutUserInteraction : Bool {
        permissions & 0b01 != 0
    }
}