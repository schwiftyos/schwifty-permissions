//
//  InternetData.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// More granular control over the internet communication a program has.
public struct InternetData : PermissionSnapshotData {
    /// URLs the program is allowed to contact.
    public private(set) var whitelist:Set<String>

    /// URLs the program is not allowed to contact.
    public private(set) var blacklist:Set<String>

    public init() {
        whitelist = []
        blacklist = []
    }
}