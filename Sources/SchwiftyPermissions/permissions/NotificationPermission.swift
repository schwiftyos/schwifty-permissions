//
//  NotificationPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

/// Notification permissions for a program.
public struct NotificationPermission : SchwiftyPermission {
    public private(set) var status:PermissionStatus

    public private(set) var displayType:DisplayType

    public private(set) var sound:String? // TODO: make struct

    @usableFromInline
    var permissions:UInt8
}

// MARK: Default
extension NotificationPermission {
    public static let `default`:Self = Self(
        status: .uponRequest,
        displayType: .list,
        sound: nil,
        permissions: .max
    )
}

// MARK: DisplayType
extension NotificationPermission {
    public enum DisplayType : Sendable {
        case count
        case stack
        case list
    }
}

// MARK: Critical
extension NotificationPermission {
}

// MARK: Time sensitive
extension NotificationPermission {
}

// MARK: Badge
extension NotificationPermission {
    @inlinable
    public var canShowBadge : Bool {
        permissions & 0b1 != 0
    }
}

// MARK: Sound
extension NotificationPermission {
    @inlinable
    public var canPlaySound : Bool {
        permissions & 0b01 != 0
    }
}