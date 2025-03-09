// This source file is part of the Schwifty Permissions open source project
//
// Copyright (c) 2025 Evan Anderson and the Schwifty Permissions project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://github.com/schwiftyos/schwifty-permissions/LICENSE.txt for license information
// See https://github.com/schwiftyos/schwifty-permissions/CONTRIBUTORS.txt for the list of Schwifty Permissions project authors

/// Calendar permissions for a process.
public struct CalendarPermission : SchwiftyPermission {
    public static let permissionType:SchwiftyPermissionType = .calendar
    
    public private(set) var status:PermissionStatus

    @usableFromInline
    var readPermissions:UInt8

    @usableFromInline
    var writePermissions:UInt8
}

// MARK: Default
extension CalendarPermission {
    public static let `default`:Self = Self(
        status: .uponRequest,
        readPermissions: .max,
        writePermissions: .max
    )
}

// MARK: Range
extension CalendarPermission {
    /// How far into the future, or past, a process has access to.
    public enum Range : Sendable {
        /// Can access all calendar events.
        case unlimited

        /// Can only access calendar events for today.
        case today

        /// Can only access calendar events for tomorrow.
        case tomorrow

        /// Can only access calendar events from yesterday.
        case yesterday

        /// First day of the week until the last.
        /// 
        /// - Gregorian: Sunday - Saturday
        case thisCalendarWeek

        /// First day of the month until the last.
        case thisCalendarMonth

        /// First day of the year until the last.
        case thisCalendarYear

        case pastCalendarHours(Int)
        case pastCalendarDays(Int)
        case pastCalendarWeeks(Int)
        case pastCalendarMonths(Int)
        case pastCalendarYears(Int)
    }
}

// MARK: Read
extension CalendarPermission {
    @inlinable
    public var canRead : Bool {
        readPermissions & 0b1 != 0
    }
}

// MARK: Write
extension CalendarPermission {
    @inlinable
    public var canWrite : Bool {
        writePermissions & 0b1 != 0
    }
}