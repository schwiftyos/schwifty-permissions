//
//  NetworkPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

/// Network permissions for a program.
public struct NetworkPermission : SchwiftyPermission {
    public private(set) var status:PermissionStatus

    /// URLs the program is allowed to contact.
    public private(set) var urlWhitelist:Set<String>

    /// URLs the program is not allowed to contact.
    public private(set) var urlBlacklist:Set<String>

    @usableFromInline
    var downloadPermissions:UInt8

    @usableFromInline
    var uploadPermissions:UInt8
}

// MARK: Default
extension NetworkPermission {
    public static let `default`:Self = Self(
        status: .uponRequest,
        urlWhitelist: [],
        urlBlacklist: [],
        downloadPermissions: .max,
        uploadPermissions: .max
    )
}

// MARK: ConnectionType
extension NetworkPermission {
    public enum ConnectionType : Sendable {
        case local
        case wired
        case wireless
        case hotspot
        case cellular
        case vpn
    }

    @inlinable
    public func canDownload(from url: String, over connection: ConnectionType) -> Bool {
        guard (urlWhitelist.isEmpty || urlWhitelist.contains(url)) && !urlBlacklist.contains(url) else { return false }
        switch connection {
        case .local: return canDownloadLocal
        case .wired: return canDownloadWired
        case .wireless: return canDownloadWired
        case .hotspot: return canDownloadHotspot
        case .cellular: return canDownloadCellular
        case .vpn: return canDownloadVPN
        @unknown default: return false
        }
    }

    @inlinable
    public func canUpload(to url: String, over connection: ConnectionType) -> Bool {
        guard (urlWhitelist.isEmpty || urlWhitelist.contains(url)) && !urlBlacklist.contains(url) else { return false }
        switch connection {
        case .local: return canUploadLocal
        case .wired: return canUploadWired
        case .wireless: return canUploadWired
        case .hotspot: return canUploadHotspot
        case .cellular: return canUploadCellular
        case .vpn: return canUploadVPN
        @unknown default: return false
        }
    }
}

// MARK: Local
extension NetworkPermission {
    /// Whether or not a program can download data over the local network.
    @inlinable
    public var canDownloadLocal : Bool {
        downloadPermissions & 0b1 != 0
    }

    /// Whether or not a program can upload data over the local network.
    @inlinable
    public var canUploadLocal : Bool {
        uploadPermissions & 0b1 != 0
    }
}

// MARK: Wired
extension NetworkPermission {
    /// Whether or not a program can download data over a wired connection.
    @inlinable
    public var canDownloadWired : Bool {
        downloadPermissions & 0b01 != 0
    }

    /// Whether or not a program can upload data over a wired connection.
    @inlinable
    public var canUploadWired : Bool {
        uploadPermissions & 0b01 != 0
    }
}

// MARK: WIFI
extension NetworkPermission {
    /// Whether or not a program can download data over a wireless connection.
    @inlinable
    public var canDownloadWIFI : Bool {
        downloadPermissions & 0b001 != 0
    }

    /// Whether or not a program can upload data over a wireless connection.
    @inlinable
    public var canUploadWIFI : Bool {
        uploadPermissions & 0b001 != 0
    }
}

// MARK: Hotspot
extension NetworkPermission {
    /// Whether or not a program can download data over a hotspot connection.
    @inlinable
    public var canDownloadHotspot : Bool {
        downloadPermissions & 0b0001 != 0
    }

    /// Whether or not a program can upload data over a hotspot connection.
    @inlinable
    public var canUploadHotspot : Bool {
        uploadPermissions & 0b0001 != 0
    }
}

// MARK: Cellular
extension NetworkPermission {
    /// Whether or not a program can download data over a cellular connection.
    @inlinable
    public var canDownloadCellular : Bool {
        downloadPermissions & 0b00001 != 0
    }

    /// Whether or not a program can upload data over a cellular connection.
    @inlinable
    public var canUploadCellular : Bool {
        uploadPermissions & 0b00001 != 0
    }
}

// MARK: VPN
extension NetworkPermission {
    /// Whether or not a program can download data over a vpn connection.
    @inlinable
    public var canDownloadVPN : Bool {
        downloadPermissions & 0b000001 != 0
    }

    /// Whether or not a program can upload data over a vpn connection.
    @inlinable
    public var canUploadVPN : Bool {
        uploadPermissions & 0b000001 != 0
    }
}