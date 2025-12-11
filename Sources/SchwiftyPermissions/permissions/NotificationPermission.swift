
/// Notification permissions for a process.
public struct NotificationPermission: SchwiftyPermission {
    public static let permissionType = SchwiftyPermissionType.notification

    public private(set) var status:PermissionStatus

    var permissions:UInt8

    var sendPermissions:AlertType.RawValue
}

// MARK: Default
extension NotificationPermission {
    public static let `default` = Self(
        status: .uponRequest,
        permissions: .max,
        sendPermissions: .max
    )
}

// MARK: AlertType
extension NotificationPermission {
    public enum AlertType: UInt8, Sendable {
        /// Regular notification.
        case normal        = 1

        /// Warning, hazard, critical notification.
        case critical      = 2

        // TODO: add documentation
        case timeSensitive = 4
    }

    public func canSend(_ alertType: AlertType = .normal) -> Bool {
        return canSend && (sendPermissions & alertType.rawValue != 0)
    }
}

// MARK: Send
extension NotificationPermission {
    public var canSend: Bool {
        permissions & 0b1 != 0
    }
}

// MARK: Badge
extension NotificationPermission {
    public var canShowBadge: Bool {
        permissions & 0b01 != 0
    }
}

// MARK: Sound
extension NotificationPermission {
    public var canPlaySound: Bool {
        permissions & 0b001 != 0
    }
}
