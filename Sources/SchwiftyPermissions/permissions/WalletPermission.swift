//
//  WalletPermission.swift
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

/// Wallet permissions for a program.
public struct WalletPermission : SchwiftyPermission {
    public static let permissionType:SchwiftyPermissionType = .wallet

    public private(set) var status:PermissionStatus

#if canImport(FoundationEssentials) || canImport(Foundation)
    /// The allowed credit cards a program has access to.
    public private(set) var creditCards:[UUID]

    /// The allowed debit cards a program has access to.
    public private(set) var debitCards:[UUID]
#else
    /// The allowed credit cards a program has access to.
    public private(set) var creditCards:[UInt64]

    /// The allowed debit cards a program has access to.
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