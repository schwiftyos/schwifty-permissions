// This source file is part of the Schwifty Permissions open source project
//
// Copyright (c) 2025 Evan Anderson and the Schwifty Permissions project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://github.com/schwiftyos/schwifty-permissions/LICENSE.txt for license information
// See https://github.com/schwiftyos/schwifty-permissions/CONTRIBUTORS.txt for the list of Schwifty Permissions project authors

public final class SystemPermissions : @unchecked Sendable {
    var _calendar:CalendarPermission! = nil
    var _disk:DiskPermission! = nil
    var _location:LocationPermission! = nil
    var _manipulation:ManipulatePermission! = nil
    var _network:NetworkPermission! = nil
    var _notifications:NotificationPermission! = nil
    var _wallet:WalletPermission! = nil

    @usableFromInline
    init() {
    }
}

// MARK: Calendar
extension SystemPermissions {
    public var calendar : CalendarPermission {
        get {
            if _calendar == nil { _calendar = .loadSystemSettings() }
            return _calendar
        }
        set { _calendar = newValue }
    }
}

// MARK: Disk
extension SystemPermissions {
    public private(set) var disk : DiskPermission {
        get {
            if _disk == nil { _disk = .loadSystemSettings() }
            return _disk
        }
        set { _disk = newValue }
    }
}

// MARK: Location
extension SystemPermissions {
    public private(set) var location : LocationPermission {
        get {
            if _location == nil { _location = .loadSystemSettings() }
            return _location
        }
        set { _location = newValue }
    }
}

// MARK: Manipulation
extension SystemPermissions {
    public private(set) var manipulation : ManipulatePermission {
        get {
            if _manipulation == nil { _manipulation = .loadSystemSettings() }
            return _manipulation
        }
        set { _manipulation = newValue }
    }
}

// MARK: Network
extension SystemPermissions {
    public private(set) var network : NetworkPermission {
        get {
            if _network == nil { _network = .loadSystemSettings() }
            return _network
        }
        set { _network = newValue }
    }
}

// MARK: Notifications
extension SystemPermissions {
    public private(set) var notifications : NotificationPermission {
        get {
            if _notifications == nil { _notifications = .loadSystemSettings() }
            return _notifications
        }
        set { _notifications = newValue }
    }
}

// MARK: Wallet
extension SystemPermissions {
    public private(set) var wallet : WalletPermission {
        get {
            if _wallet == nil { _wallet = .loadSystemSettings() }
            return _wallet
        }
        set { _wallet = newValue }
    }
}