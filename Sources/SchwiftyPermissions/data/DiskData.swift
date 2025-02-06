//
//  DiskData.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

public struct DiskData : PermissionSnapshotData {
    /// Absolute paths the program can access.
    public private(set) var whitelist:Set<String>

    /// Absolute paths the program cannot access.
    public private(set) var blacklist:Set<String>

    public init() {
        whitelist = []
        blacklist = []
    }
}