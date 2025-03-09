// This source file is part of the Schwifty Permissions open source project
//
// Copyright (c) 2025 Evan Anderson and the Schwifty Permissions project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://github.com/schwiftyos/schwifty-permissions/LICENSE.txt for license information
// See https://github.com/schwiftyos/schwifty-permissions/CONTRIBUTORS.txt for the list of Schwifty Permissions project authors

public struct Program : Sendable {
    public typealias ApplicationID = String
    public typealias ProcessID = UInt64

    public let applicationID:ApplicationID
    public let pid:ProcessID

    /// Process owner.
    /// 
    /// - Warning: All programs are minimally owned by the root process
    public private(set) var ownerpid:ProcessID

    /// Current processing state of this program.
    public private(set) var state:ProgramState

    init(
        ownerpid: ProcessID = 0,
        pid: ProcessID,
        state: ProgramState = .notRunning,
        applicationID: String
    ) {
        self.applicationID = applicationID
        self.pid = pid
        self.ownerpid = ownerpid
        self.state = state
    }
}

// MARK: Equatable
extension Program : Equatable {
    @inlinable
    public static func == (lhs: Program, rhs: Program) -> Bool {
        return lhs.ownerpid == rhs.ownerpid && lhs.pid == rhs.pid
    }
}

// MARK: Hashable
extension Program : Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ownerpid)
        hasher.combine(pid)
    }
}

// MARK: Permissions
extension Program {
    /// Request the use of a permission.
    /// 
    /// - Parameters:
    ///   - permission: Permission you want to request.
    ///   - reason: Reason why the program is requesting the permission.
    @inlinable
    public func request<T: SchwiftyPermission>(
        _ permission: SchwiftyPermissionType,
        reason: String
    ) async -> Result<T, PermissionError> {
        return await PermissionStorage.shared.permissions(for: self).request(permission, for: self, reason: reason)
    }
}