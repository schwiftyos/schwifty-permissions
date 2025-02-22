//
//  Program.swift
//
//
//  Created by MinerMinerMods on 2/9/25.
//

/// Declares a Program with
public actor Program {
	public typealias PID = UInt64

	public private(set) var name:String
	public private(set) var pid:PID

	/// Indicates the owner proccess.
	/// - Warning: All programs are minimally owned by the root proccess
	public private(set) var ownerpid:PID = 0

	public internal(set) var permissions:[SchwiftyPermission] {
		get { _permissions }
		set (new) {
			guard new != _permissions else { return }
			guard _permissions.contains(.programRequestPermissionChanges) else {
				throw PermissionError.requestDisallowed(reason:"Missing SchwiftyPermission.programRequestPermissionChanges")
			}
			for (i, item) in new.enumerated() {
				if !(_permissions.contains(item)) {
					do {
						_permissions.append( try self.requestPermission(item).get() )
					} catch(let error) {
						print("Unable to authorize the permission: \(item).")
						#if DEBUG
							print(error)
						#else
							print("Use DEBUG for more info")
						#endif
					}
				}
			}
		}
	}

	// To prevent a Program instance from arbitraily messing around with this from an extension
	fileprivate var _permissions:[SchwiftyPermission] = []

	public init(name:String? = nil, pid:PID) {
		self.name = name ?? "Program \(pid)"
		self.pid = pid
	}

	public func requestPermission(_ perm: SchwiftyPermission) throws -> Result<[ProcessPermissions], PermissionError> {
		guard permissions.contains(SchwiftyPermission.programRequestPermissionChanges) || perm == SchwiftyPermission.programRequestPermissionChanges else { throw PermissionError.requestDisallowed(reason:"Missing Required Permission `.programRequestPermissionChanges`") }
		guard permissions.contains(perm) else {return true}
		var result = await requestPermission( for: SchwiftyPermission, onBehalfOf: self)
		guard result.status != .never else {
			return .failure(.operationDenied)
		}
		return .success(result)
	}

	/// Causes all access to
	package func refreshPermissions() {
		self.permissions = PermissionStorage.shared.programs[self]
	}

	internal func refreshPermissions(from permStore: PermissionStorage) {
		self.permissions = permStore.programs[self.hash()]
	}

	package func updateRefrence(in permStore: PermissionStorage) {
		permStore.changeRefrence(oldhash, currenthash)
	}
}

extension Program:Hashable{
	public isolated func hash() -> Int {
		var hasher = Hasher()
		self.hash(into: &hasher)
		return hasher.finalize()
	}

	public isolated func hash(into hasher: inout Hasher) {
		hasher.combine(pid)
		hasher.combine(name)
		hasher.combine(ownerpid)
	}
}

extension Program: Equatable {

}