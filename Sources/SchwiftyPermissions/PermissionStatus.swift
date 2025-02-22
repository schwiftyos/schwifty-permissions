//
//  PermissionStatus.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

// TODO: fix (Module [Foundation, FoundationEssentials] was not compiled with library evolution support; using it means binary compatibility for 'SchwiftyPermissions' can't be guaranteed)
#if canImport(FoundationEssentials)
import FoundationEssentials
#elseif canImport(Foundation)
import Foundation
#endif

/// List of available statuses a permission can have.
public enum PermissionStatus : Hashable, Sendable {
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

    #if canImport(FoundationEssentials) || canImport(Foundation)
    /// Access is only allowed temporarily, until a set time.
    case temporarilyUntil(Date)
    #endif

    /// Access is only allowed temporarily, between two given times of day.
    //case temporarilyBetween(Double, Double) // TODO: support
}

extension PermissionStatus {
    @inlinable
    public func isAllowed(for state: ProgramState) -> Bool {
        switch self {
        case .never: return false
        case .always: return true
        case .onlyInUse: return state != .notRunning
        case .onlyInBackground: return state == .background
        case .onlyInForeground: return state == .foreground
        case .uponRequest: return true // TODO: fix

        #if canImport(FoundationEssentials) || canImport(Foundation)
        case .temporarilyUntil(let expires): return Date.now <= expires
        #endif

        @unknown default: return false
        }
    }
}