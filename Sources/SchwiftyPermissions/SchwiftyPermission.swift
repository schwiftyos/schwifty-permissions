//
//  SchwiftyPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

public protocol SchwiftyPermission : Sendable {
    /// Default permissions.
    static var `default` : Self { get }

    /// Current status of a permission.
    var status : PermissionStatus { get }
}