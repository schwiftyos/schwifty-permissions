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

/// Wallet permissions for a process.
public struct WalletPermission : SchwiftyPermission {
    public static let permissionType:SchwiftyPermissionType = .wallet

    public private(set) var status:PermissionStatus

#if canImport(FoundationEssentials) || canImport(Foundation)
    /// Allowed credit cards a process has access to.
    public private(set) var creditCards:[UUID]

    /// Allowed debit cards a process has access to.
    public private(set) var debitCards:[UUID]
#else
    /// Allowed credit cards a process has access to.
    public private(set) var creditCards:[UInt64]

    /// Allowed debit cards a process has access to.
    public private(set) var debitCards:[UInt64]
#endif
}

// MARK: Default
extension WalletPermission {
    public static let `default`:Self = Self(
        status: .uponRequest,
        creditCards: [],
        debitCards: []
    )
}