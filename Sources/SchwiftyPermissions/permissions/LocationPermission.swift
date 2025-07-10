
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