
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