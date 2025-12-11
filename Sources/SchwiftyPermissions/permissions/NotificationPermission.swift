
/// Notification permissions for a process.
public struct NotificationPermission: SchwiftyPermission {
    public static let permissionType = SchwiftyPermissionType.notification

    public private(set) var status:PermissionStatus

    var permissions:Flag.RawValue

    var sendPermissions:AlertType.RawValue
}

// MARK: Flag
extension NotificationPermission {
    enum Flag: UInt8, Sendable {
        case send      = 1
        case showBadge = 2
        case playSound = 4

        /// - Returns: If the flag is enabled in the given `permissions`.
        func isEnabled(_ permissions: RawValue) -> Bool {
            permissions & rawValue > 0
        }
    }
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

        func isEnabled(_ permissions: RawValue) -> Bool {
            permissions & rawValue > 0
        }
    }

    /// - Returns: If a notification with the given `AlertType` can be sent.
    public func canSendAlertType(_ alertType: AlertType) -> Bool {
        return canSend && alertType.isEnabled(sendPermissions)
    }
}

// MARK: Send
extension NotificationPermission {
    /// - Returns: If sending a notification is allowed.
    public var canSend: Bool {
        Flag.send.isEnabled(permissions)
    }
}

// MARK: Badge
extension NotificationPermission {
    /// - Returns: If showing a notification badge is allowed.
    public var canShowBadge: Bool {
        Flag.showBadge.isEnabled(permissions)
    }
}

// MARK: Sound
extension NotificationPermission {
    /// - Returns: If playing a notification sound is allowed.
    public var canPlaySound: Bool {
        Flag.playSound.isEnabled(permissions)
    }
}

// MARK: Modifications
extension NotificationPermission {
    /// Mutates `permissions` to reflect the new status for the given `flag`.
    private mutating func updateFlag(_ flag: Flag, isEnabled: Bool) {
        permissions = isEnabled ? permissions | flag.rawValue : permissions & ~flag.rawValue
    }

    /// Mutates `permissions` to reflect the new `send` flag status.
    mutating func setCanSend(_ newValue: Bool) {
        updateFlag(.send, isEnabled: newValue)
    }

    /// Mutates `permissions` to reflect the new `showBadge` flag status.
    mutating func setCanShowBadge(_ newValue: Bool) {
        updateFlag(.showBadge, isEnabled: newValue)
    }

    /// Mutates `permissions` to reflect the new `playSound` flag status.
    mutating func setCanPlaySound(_ newValue: Bool) {
        updateFlag(.playSound, isEnabled: newValue)
    }

    /// Mutates `sendPermissions` to reflect the new alert type flag status.
    mutating func setCanSendAlertType(_ alertType: AlertType, newValue: Bool) {
        sendPermissions = newValue ? sendPermissions | alertType.rawValue : sendPermissions & ~alertType.rawValue
    }
}