//
//  PermissionError.swift
//
//
//  Created by Evan Anderson on 2/17/25.
//

public enum PermissionError : Error {
    case operationDenied

    case notOnWhitelist
    case onBlacklist
}