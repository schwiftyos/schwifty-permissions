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
}

// MARK: Default
extension NotificationPermission {
    public static let `default`:Self = Self(
        status: .uponRequest,
        permissions: .max
    )
}

// MARK: Send
extension NotificationPermission {
    @inlinable
    public var canSend : Bool {
        permissions & 0b1 != 0
    }

    @inlinable
    public var canSendCritical : Bool {
        permissions & 0b01 != 0
    }

    @inlinable
    public var canSendTimeSensitive : Bool {
        permissions & 0b001 != 0
    }
}

// MARK: Badge
extension NotificationPermission {
    @inlinable
    public var canShowBadge : Bool {
        permissions & 0b0001 != 0
    }
}

// MARK: Sound
extension NotificationPermission {
    @inlinable
    public var canPlaySound : Bool {
        permissions & 0b00001 != 0
    }
}