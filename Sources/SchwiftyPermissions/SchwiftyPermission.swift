//
//  SchwiftyPermission.swift
//
//
//  Created by Evan Anderson on 2/6/25.
//

/// List of permissions that control how programs can behave.
public enum SchwiftyPermission : Sendable {
    // MARK: general

    /// Whether or not this program can read the system's audio output.
    case audioRead

    /// Whether or not this program can write to the system's audio output.
    case audioPlay

    case bluetooth

    /// Whether or not this program can access the system's camera input.
    case camera

    /// Whether or not this program can access the system's location.
    case location

    /// Whether or not this program can read the microphone input.
    case microphoneRead

    /// Whether or not this program can write to the microphone input.
    case microphoneWrite

    // MARK: network
    // localNetwork
    case localNetworkDownload
    case localNetworkUpload

    // internet
    case internetDownload
    case internetUpload

    // wifi
    case wifiDownload
    case wifiUpload

    // cellular
    case cellularDownload
    case cellularUpload
    
    // hotspot
    case hotspotDownload
    case hotspotUpload

    // MARK: disk
    /// Whether or not this program can read data on disk.
    case diskRead

    /// Whether or not this program can write data to disk.
    case diskWrite

    case inputMonitoring

    case liveActivities
    case loginItem

    case notifications
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

    // MARK: program manipulation
    /// Whether or not this program can manipulate a running program on the system without direct user interaction.
    case programManipulation

    /// Whether or not this program can request permission changes of another program.
    case programRequestPermissionChanges

    /// Whether or not this program can grant permission changes of another program.
    case programGrantPermissionChanges

    // MARK: continuity
    case calendar
    case contacts
    case mail
    case notes
    case music
    case passkeys
    case passwords
    case photos
    case reminders
    case wallet
}