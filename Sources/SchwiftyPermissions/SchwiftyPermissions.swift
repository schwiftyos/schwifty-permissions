//
//  SchwiftyPermissions.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

public struct SchwiftyPermissions : Sendable {
    @MainActor public static var shared:SchwiftyPermissions = SchwiftyPermissions()

    var programs:[UInt64:ProcessPermissions]

    public init() {
        programs = [:]
    }

    public func load() {
    }
}