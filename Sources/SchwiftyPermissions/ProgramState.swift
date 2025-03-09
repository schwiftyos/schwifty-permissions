// This source file is part of the Schwifty Permissions open source project
//
// Copyright (c) 2025 Evan Anderson and the Schwifty Permissions project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://github.com/schwiftyos/schwifty-permissions/LICENSE.txt for license information
// See https://github.com/schwiftyos/schwifty-permissions/CONTRIBUTORS.txt for the list of Schwifty Permissions project authors

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