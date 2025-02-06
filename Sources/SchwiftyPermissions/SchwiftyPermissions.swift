//
//  SchwiftyPermissions.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

public struct SchwiftyPermissions : Sendable {
    @MainActor public static var shared:SchwiftyPermissions = SchwiftyPermissions()

    var applications:[UInt64:ApplicationPermissions]

    public init() {
        applications = [:]
    }

    public func load() {
    }
}