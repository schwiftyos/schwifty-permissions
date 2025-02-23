//
//  NotificationPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

/// Notification permissions for a program.
public struct NotificationPermission : SchwiftyPermission {
    public private(set) var status:PermissionStatus

    @usableFromInline
    var permissions:UInt8

    @usableFromInline
    var sendPermissions:AlertType.RawValue
}

// MARK: Default
extension NotificationPermission {
    public static let `default`:Self = Self(
        status: .uponRequest,
        permissions: .max,
        sendPermissions: .max
    )
}

// MARK: AlertType
extension NotificationPermission {
    public enum AlertType : UInt8, Sendable {
        /// Regular notification.
        case normal        = 1

        /// Warning, hazard, critical notification.
        case critical      = 2

        // TODO: add documentation
        case timeSensitive = 4
    }

    @inlinable
    public func canSend(_ alertType: AlertType = .normal) -> Bool {
        return canSend && (sendPermissions & alertType.rawValue != 0)
    }
}

// MARK: Send
extension NotificationPermission {
    @inlinable
    public var canSend : Bool {
        permissions & 0b1 != 0
    }
}

// MARK: Badge
extension NotificationPermission {
    @inlinable
    public var canShowBadge : Bool {
        permissions & 0b01 != 0
    }
}

// MARK: Sound
extension NotificationPermission {
    @inlinable
    public var canPlaySound : Bool {
        permissions & 0b001 != 0
    }
}
