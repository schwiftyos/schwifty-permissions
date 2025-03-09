// This source file is part of the Schwifty Permissions open source project
//
// Copyright (c) 2025 Evan Anderson and the Schwifty Permissions project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://github.com/schwiftyos/schwifty-permissions/LICENSE.txt for license information
// See https://github.com/schwiftyos/schwifty-permissions/CONTRIBUTORS.txt for the list of Schwifty Permissions project authors

/// Location permissions for a process.
public struct LocationPermission : SchwiftyPermission {
    public static let permissionType:SchwiftyPermissionType = .location

    public private(set) var status:PermissionStatus

    public private(set) var accuracy:Accuracy
}

// MARK: Default
extension LocationPermission {
    public static let `default`:Self = Self(
        status: .uponRequest,
        accuracy: .approximate
    )
}

// MARK: Accuracy
extension LocationPermission {
    public enum Accuracy : Sendable {
        case approximate
        case precise
    }
}