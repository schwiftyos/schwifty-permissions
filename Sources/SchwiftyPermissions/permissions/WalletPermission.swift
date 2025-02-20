//
//  WalletPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

#if canImport(FoundationEssentials)
import FoundationEssentials // TODO: fix
#elseif canImport(Foundation)
import Foundation // TODO: fix
#endif

/// Wallet permissions for a program.
public struct WalletPermission : SchwiftyPermission {
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