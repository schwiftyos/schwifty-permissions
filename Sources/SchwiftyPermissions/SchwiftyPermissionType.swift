// This source file is part of the Schwifty Permissions open source project
//
// Copyright (c) 2025 Evan Anderson and the Schwifty Permissions project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://github.com/schwiftyos/schwifty-permissions/LICENSE.txt for license information
// See https://github.com/schwiftyos/schwifty-permissions/CONTRIBUTORS.txt for the list of Schwifty Permissions project authors

/// List of permissions that control how a system can behave.
public enum SchwiftyPermissionType : Sendable {
    /*// MARK: general

    /// Read the system's audio output.
    case audioRead

    /// Write to the system's audio output.
    case audioPlay

    case bluetooth

    /// Access the system's camera input.
    case camera

    /// Read the microphone input.
    case microphoneRead

    /// Write to the microphone input.
    case microphoneWrite

    case inputMonitoring

    case liveActivities
    case loginItem

    case remoteDesktop
    case screenRecording
    case search
    case speechRecognition

    // MARK: system
    case systemArchitecture
    case systemTemperatures
    case systemNetworkStatus
    case systemInstalledPrograms
    case systemInstalledWidgets

    // MARK: continuity
    case contacts
    case mail
    case notes
    case music
    case passkeys
    case passwords
    case photos
    case reminders*/

    // MARK: Implemented
    case calendar
    case disk
    case location
    case manipulation
    case network
    case notification
    case wallet
}