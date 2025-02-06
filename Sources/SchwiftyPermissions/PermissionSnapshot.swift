//
//  PermissionSnapshot.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// Current snapshot of a permission.
public struct PermissionSnapshot<T: PermissionSnapshotData> : AnyPermissionSnapshot {
    public private(set) var status:PermissionStatus = .never
    public private(set) var data:T
}