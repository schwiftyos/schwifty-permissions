//
//  Program.swift
//
//
//  Created by MinerMinerMods on 2/9/25.
//

public struct Program : Sendable {
	public typealias ApplicationID = String
	public typealias ProcessID = UInt64
	
	public let applicationID:ApplicationID
	public let pid:ProcessID

	/// The process owner.
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
	@inlinable
	public func request<T: SchwiftyPermission>(
		_ permission: SchwiftyPermissionType,
		reason: String
	) async throws -> Result<T, PermissionError> {
		return await PermissionStorage.shared.permissions(for: self).request(permission, for: self, reason: reason)
	}
}