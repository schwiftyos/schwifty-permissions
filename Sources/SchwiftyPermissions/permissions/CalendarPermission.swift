//
//  CalendarPermission.swift
//
//
//  Created by Evan Anderson on 2/19/25.
//

/// Calendar permissions for a program.
public struct CalendarPermission : SchwiftyPermission {
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
    /// How far into the future, or past, a program has access to.
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