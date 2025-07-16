
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