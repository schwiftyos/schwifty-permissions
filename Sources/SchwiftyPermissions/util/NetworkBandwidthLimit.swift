
import SchwiftyUtilities

/// Network bandwidth limits.
public struct NetworkBandwidthLimit : Sendable {
    /// Number of bytes allowed to download.
    public private(set) var download:BinaryUnit

    /// Number of bytes allowed to upload.
    public private(set) var upload:BinaryUnit
}

// MARK: NetworkPermission
extension NetworkPermission {
    /// - Returns: The `NetworkBandwidthLimit` for a `ConnectionType`.
    @inlinable
    public func bandwidthLimit(for connection: ConnectionType) -> NetworkBandwidthLimit? {
        switch connection {
        case .local: return bandwidthLimits?.local
        case .wired: return bandwidthLimits?.wired
        case .wireless: return bandwidthLimits?.wireless
        case .hotspot: return bandwidthLimits?.hotspot
        case .cellular: return bandwidthLimits?.cellular
        case .vpn: return bandwidthLimits?.vpn
        @unknown default: return nil
        }
    }

    /// - Returns: The active `NetworkBandwidthLimit` for a `ConnectionType`.
    /// Defaults to the system network bandwidth limit for the connection type, if configured.
    @inlinable
    public func activeBandwidthLimit(for connection: ConnectionType) async -> NetworkBandwidthLimit? {
        var limit = bandwidthLimit(for: connection)
        if limit == nil {
            limit = await PermissionStorage.shared.system.network.bandwidthLimit(for: connection)
        }
        return limit
    }
}