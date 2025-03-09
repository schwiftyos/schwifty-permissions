//
//  ProgramState.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

// TODO: fix (Module [Foundation, FoundationEssentials] was not compiled with library evolution support; using it means binary compatibility for 'SchwiftyPermissions' can't be guaranteed)
#if canImport(FoundationEssentials)
import FoundationEssentials
#elseif canImport(Foundation)
import Foundation
#endif

import SchwiftyUtilities

/// Current state of a program.
public enum ProgramState : Hashable, Sendable {
    case foreground
    case background
    case notRunning
}

extension ProgramState {
    /// Whether or not this program state allows the use of a permission, given its status.
    @inlinable
    public func allowsPermissionStatus(_ status: PermissionStatus) -> Bool {
        switch status {
        case .never: return false
        case .always: return true
        case .onlyInUse: return self != .notRunning
        case .onlyInBackground: return self == .background
        case .onlyInForeground: return self == .foreground
        case .uponRequest: return true

        #if canImport(FoundationEssentials) || canImport(Foundation)
        case .temporarilyUntil(let expires): return Date.now() < expires
        #endif

        @unknown default: return false
        }
    }
}