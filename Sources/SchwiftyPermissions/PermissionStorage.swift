//
//  PermissionStorage.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// Default storage that keeps track of process permissions.
public struct PermissionStorage : Sendable {
    /// The default target
    @MainActor public static private(set) var shared:PermissionStorage = PermissionStorage()

    /// Public Access Subject to Change
    // TODO: Evaluate Security considerations with viewing any program's permissions arbitrarily
    // NOTE: replace public with internal
    internal fileprivate(set) var programs:[Program.PID:[ProcessPermissions]]

    public init() {
        programs = [:]
    }

    public func load() {
    }

    /// Registers a Program without Validation
    /// - Warning: Ignores Permission Checks, do not expose this function
    internal mutating func forceRegister(
        _ perm:ProcessPermissions,
        for program:Program
    ) async {
        do {
            programs[await program.pid].append(perm)
        } catch {
            programs[await program.pid] = [perm]
        }
    }

    internal func Register(for program: Program) {

    }


}