//
//  PermissionStatus.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// Current status of a permission.
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

    /// Access is only allowed temporarily, until a set time.
    case temporarily(ContinuousClock.Instant)
}

extension PermissionStatus {
    public func isAllowed(state: ProgramState) -> Bool {
        switch self {
        case .never: return false
        case .always: return true
        case .onlyInUse: return state != .notRunning
        case .onlyInBackground: return state == .background
        case .onlyInForeground: return state == .foreground
        case .uponRequest: return true // TODO: fix
        case .temporarily(let expires): return ContinuousClock.now <= expires
        }
    }
}