// This source file is part of the Schwifty Permissions open source project
//
// Copyright (c) 2025 Evan Anderson and the Schwifty Permissions project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://github.com/schwiftyos/schwifty-permissions/LICENSE.txt for license information
// See https://github.com/schwiftyos/schwifty-permissions/CONTRIBUTORS.txt for the list of Schwifty Permissions project authors

public enum PermissionCategory : Sendable {
    case audio
    case bluetooth
    case camera
    case calendar
    case contacts
    case disk
    case health
    case liveActivity
    case location
    case mail
    case microphone
    case music
    case network
    case notes
    case notifications
    case passkeys
    case passwords
    case photos
    case reminders
    case search
    case wallet
}