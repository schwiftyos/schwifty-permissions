//
//  AnyPermissionSnapshot.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// A snapshot of a permission.
public protocol AnyPermissionSnapshot : Sendable {
    var status : PermissionStatus { get }
}