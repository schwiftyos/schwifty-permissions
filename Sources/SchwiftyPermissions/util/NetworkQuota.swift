// This source file is part of the Schwifty Permissions open source project
//
// Copyright (c) 2025 Evan Anderson and the Schwifty Permissions project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://github.com/schwiftyos/schwifty-permissions/LICENSE.txt for license information
// See https://github.com/schwiftyos/schwifty-permissions/CONTRIBUTORS.txt for the list of Schwifty Permissions project authors

#if canImport(FoundationEssentials)
import FoundationEssentials
#elseif canImport(Foundation)
import Foundation
#endif

import SchwiftyUtilities

// MARK: NetworkQuota
/// Limits the amount of bytes a process can download/upload within a time frame.
public struct NetworkQuota : Sendable {
    #if canImport(FoundationEssentials) || canImport(Foundation)
    /// When tracking of the quota begins.
    public private(set) var starts:Date

    /// When tracking of the quota ends.
    public private(set) var ends:Date
    #endif

    /// Number of bytes allowed to download.
    public private(set) var download:UInt64

    /// Current number of bytes downloaded.
    public private(set) var downloaded:UInt64

    /// Number of bytes allowed to upload.
    public private(set) var upload:UInt64

    /// Current number of bytes uploaded.
    public private(set) var uploaded:UInt64        
}

// MARK: NetworkPermission
extension NetworkPermission {
    /// - Returns: The `NetworkQuota` for a `ConnectionType`.
    @inlinable
    public func quota(for connection: ConnectionType) -> NetworkQuota? {
        switch connection {
        case .local: return quotas?.local
        case .wired: return quotas?.wired
        case .wireless: return quotas?.wireless
        case .hotspot: return quotas?.hotspot
        case .cellular: return quotas?.cellular
        case .vpn: return quotas?.vpn
        @unknown default: return nil
        }
    }

    /// - Returns: The active `NetworkQuota` for a `ConnectionType`.
    /// Defaults to the system network quota for the connection type, if configured.
    @inlinable
    public func activeQuota(for connection: ConnectionType) async -> NetworkQuota? {
        var quota = quota(for: connection)
        if quota == nil {
            quota = await PermissionStorage.shared.system.network.quota(for: connection)
        }
        #if canImport(FoundationEssentials) || canImport(Foundation)
        if let quota {
            let now:Date = Date.now()
            guard now >= quota.starts && now < quota.ends else { return nil }
        }
        #endif
        return quota
    }
    
    /// - Returns: Whether or not a number of bytes can be downloaded over a connection type, taking into account the active quota.
    @inlinable
    public func canDownload(bytes: UInt64, over connection: ConnectionType) async -> Bool {
        guard let quota = await activeQuota(for: connection) else { return true }
        return quota.downloaded + bytes <= quota.download
    }

    /// - Returns: Whether or not a number of bytes can be uploaded over a connection type, taking into account the active quota.
    @inlinable
    public func canUpload(bytes: UInt64, over connection: ConnectionType) async -> Bool {
        guard let quota = await activeQuota(for: connection) else { return true }
        return quota.uploaded + bytes <= quota.upload
    }
}