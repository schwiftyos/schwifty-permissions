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

/// List of available statuses a permission can have.
public enum PermissionStatus : Hashable, Sendable {
    /// Access is never allowed.
    case never

    /// Access is always allowed.
    case always

    /// Access is only allowed when the process is in use (in background or foreground).
    case onlyInUse

    /// Access is only allowed when the process is in the background.
    case onlyInBackground

    /// Access is only allowed when the process is in the foreground.
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