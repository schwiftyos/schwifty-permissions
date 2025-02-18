//
//  SchwiftyPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

public protocol SchwiftyPermission : Sendable {
    var status : PermissionStatus { get }
}