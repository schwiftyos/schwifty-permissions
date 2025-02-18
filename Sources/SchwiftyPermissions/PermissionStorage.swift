//
//  PermissionStorage.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// Default storage that keeps track of process permissions.
public struct PermissionStorage : Sendable {
    @MainActor public static private(set) var shared:PermissionStorage = PermissionStorage()

    var programs:[UInt64:ProcessPermissions]

    public init() {
        programs = [:]
    }

    public func load() {
    }
}