//
//  LocationPermission.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

/// Location permissions for a program.
public struct LocationPermission : SchwiftyPermission {
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