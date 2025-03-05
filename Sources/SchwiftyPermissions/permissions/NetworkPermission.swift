//
//  NetworkPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#elseif canImport(Foundation)
import Foundation
#endif

/// Network permissions for a process.
public struct NetworkPermission : SchwiftyPermission {
    public static let permissionType:SchwiftyPermissionType = .network

    public private(set) var status:PermissionStatus

    /// URLs the process is allowed to contact.
    public private(set) var urlWhitelist:Set<String>

    /// URLs the process is not allowed to contact.
    public private(set) var urlBlacklist:Set<String>

    /// Number of bytes per second allowed to download/upload for this process.
    public private(set) var bandwidthLimitPerSecond:BandwidthLimit?

    /// Number of bytes this process is allowed to download/upload for a period of time.
    public private(set) var quota:Quota?

    @usableFromInline
    var downloadPermissions:ConnectionType.RawValue

    @usableFromInline
    var uploadPermissions:ConnectionType.RawValue
}

// MARK: Default
extension NetworkPermission {
    public static let `default`:Self = Self(
        status: .uponRequest,
        urlWhitelist: [],
        urlBlacklist: [],
        bandwidthLimitPerSecond: nil,
        downloadPermissions: .max,
        uploadPermissions: .max
    )
}

// MARK: ConnectionType
extension NetworkPermission {
    public enum ConnectionType : UInt8, Sendable {
        case local    = 1
        case wired    = 2
        case wireless = 4
        case hotspot  = 8
        case cellular = 16
        case vpn      = 32
    }
}

// MARK: Download
extension NetworkPermission {
    /// Whether or not a process can download data over the specified connection.
    @inlinable
    public func canDownload(over connection: ConnectionType) -> Bool {
        return downloadPermissions & connection.rawValue != 0
    }

    /// Whether or not a process can download data from the specified URL over the specified connection.
    @inlinable
    public func canDownload(from url: String, over connection: ConnectionType) -> Bool {
        return canDownload(over: connection) && (urlWhitelist.isEmpty || urlWhitelist.contains(url)) && !urlBlacklist.contains(url)
    }
}

// MARK: Upload
extension NetworkPermission {
    /// Whether or not a process can upload data over the specified connection.
    @inlinable
    public func canUpload(over connection: ConnectionType) -> Bool {
        return uploadPermissions & connection.rawValue != 0
    }

    /// Whether or not a process can upload data to the specified URL over the specified connection.
    @inlinable
    public func canUpload(to url: String, over connection: ConnectionType) -> Bool {
        return canUpload(over: connection) && (urlWhitelist.isEmpty || urlWhitelist.contains(url)) && !urlBlacklist.contains(url)
    }
}

// MARK: Bandwidth
extension NetworkPermission {
    /// Network bandwidth limits.
    public struct BandwidthLimit : Sendable {
        /// Number of bytes allowed to download.
        public private(set) var download:UInt64

        /// Number of bytes allowed to upload.
        public private(set) var upload:UInt64
    }
}

// MARK: Quota
extension NetworkPermission {
    public struct Quota : Sendable {
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
}