//
//  PermissionStorage.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// Default storage that keeps track of process permissions.
/// 
/// ## Permissions
/// 
/// We support 3 independent kinds of permissions:
///   - system-wide (default)
///   - per process
///   - per program
/// 
/// This allows overriding a running process's permissions without overriding its inherited permissions,
/// which unlocks more granular control over processes and programs on a case-by-case basis.
public actor PermissionStorage : Sendable {
    /// Shared permission storage.
    @MainActor public static private(set) var shared:PermissionStorage = PermissionStorage()

    var _system:SystemPermissions!

    /// System-wide permissions that take priority over process and program permissions.
    public private(set) var system : SystemPermissions {
        get {
            if _system == nil { _system = SystemPermissions() }
            return _system
        }
        set { _system = newValue }
    }

    @usableFromInline
    var programs:[Program.ApplicationID:ProcessPermissions]

    @usableFromInline
    var processes:[Program.ProcessID:ProcessPermissions]

    public init(
        system: SystemPermissions? = nil
    ) {
        self._system = system
        programs = [:]
        processes = [:]
    }

    public func load() {
    }
}

// MARK: Processes
extension PermissionStorage {
    /// - Returns: Permissions for a process.
    @inlinable
    public func permissions(for process: Program.ProcessID) -> ProcessPermissions {
        if let cached = processes[process] {
            return cached
        }
        let value:ProcessPermissions = ProcessPermissions()
        processes[process] = value
        return value
    }

    /// Registers a process with the specified permissions.
    func register(
        process: Program.ProcessID,
        with permissions: ProcessPermissions,
        override: Bool = false
    ) {
        if override || processes[process] == nil {
            processes[process] = permissions
        } else {
            // TODO: throw error
        }
    }
}

// MARK: Programs
extension PermissionStorage {
    /// - Returns: Permissions for a program.
    @inlinable
    public func permissions(for program: Program) -> ProcessPermissions {
        if let cached = processes[program.pid] ?? programs[program.applicationID] {
            return cached
        }
        let value:ProcessPermissions = ProcessPermissions()
        programs[program.applicationID] = value
        return value
    }
    
    /// Registers a program with the specified permissions.
    func register(
        program: Program,
        with permissions: ProcessPermissions,
        override: Bool = false
    ) {
        if override || programs[program.applicationID] == nil {
            programs[program.applicationID] = permissions
        } else {
            // TODO: throw error
        }
    }
}