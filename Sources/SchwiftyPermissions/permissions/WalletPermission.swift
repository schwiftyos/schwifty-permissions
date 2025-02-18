//
//  WalletPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#elseif canImport(Foundation)
import Foundation
#endif

/// Wallet permissions for a program.
public struct WalletPermission : SchwiftyPermission {
    public private(set) var status:PermissionStatus

    var creditCards:[CreditCard]
    var debitCards:[DebitCard]
}

// MARK: Default
extension WalletPermission {
    public static let `default`:Self = Self(
        status: .never,
        creditCards: [],
        debitCards: []
    )
}

// MARK: CreditCard
extension WalletPermission {
    public struct CreditCard : Sendable {
        #if canImport(FoundationEssentials) || canImport(Foundation)
        public let id:UUID
        #else
        public let id:UInt64
        #endif

        public let label:String?
        public let number:UInt64
        public let expires:Expiration
        public let code:UInt16
    }
}

extension WalletPermission.CreditCard {
    public struct Expiration : Sendable {
        public let month:UInt8
        public let year:UInt16
    }
}

// MARK: DebitCard
extension WalletPermission {
    public struct DebitCard : Sendable {
        #if canImport(FoundationEssentials) || canImport(Foundation)
        public let id:UUID
        #else
        public let id:UInt64
        #endif

        public let label:String?
        public let number:UInt64
        public let expires:Expiration
        public let code:UInt16
    }
}

extension WalletPermission.DebitCard {
    public struct Expiration : Sendable {
        public let month:UInt8
        public let year:UInt16
    }
}