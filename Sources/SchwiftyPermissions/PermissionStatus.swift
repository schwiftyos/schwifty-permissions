//
//  PermissionStatus.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// Current status of a permission.
public enum PermissionStatus : UInt8, Sendable {
    /// Access is never allowed.
    case never

    /// Access is always allowed.
    case always

    /// Access is only allowed when the program is in use (in background or foreground).
    case onlyInUse

    /// Access is only allowed when the program is in the background.
    case onlyInBackground

    /// Access is only allowed when the program is in the foreground.
    case onlyInForeground

    /// Access is only allowed if granted by the user, when requested.
    case uponRequest

    /// Access is only allowed until the program is terminated.
    case untilTermination
}