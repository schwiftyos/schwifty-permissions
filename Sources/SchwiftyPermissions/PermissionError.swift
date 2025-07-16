
public enum PermissionError : Error {
    case operationDenied

    case notOnWhitelist
    case onBlacklist
}