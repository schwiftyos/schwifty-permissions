
@testable import SchwiftyPermissions
import Testing

@Suite
struct NotificationPermissionTests {
}

// MARK: Defaults
extension NotificationPermissionTests {
    @Test
    func notificationPermissionDefaultsCanSend() {
        #expect(NotificationPermission.default.canSend)
    }

    @Test
    func notificationPermissionDefaultsCanShowBadge() {
        #expect(NotificationPermission.default.canShowBadge)
    }

    @Test
    func notificationPermissionDefaultsCanPlaySound() {
        #expect(NotificationPermission.default.canPlaySound)
    }

    @Test(arguments: [NotificationPermission.AlertType.normal, .critical, .timeSensitive])
    func notificationPermissionDefaultsCanSendAlertTypes(alertType: NotificationPermission.AlertType) {
        #expect(NotificationPermission.default.canSendAlertType(alertType))
    }
}

// MARK: Modifications
extension NotificationPermissionTests {
    @Test
    func notificationPermissionCanSendWhenToggled() {
        var perm = NotificationPermission.default
        perm.setCanSend(false)
        #expect(!perm.canSend)

        perm.setCanSend(true)
        #expect(perm.canSend)
    }

    @Test
    func notificationPermissionCanShowBadgeWhenToggled() {
        var perm = NotificationPermission.default
        perm.setCanShowBadge(false)
        #expect(!perm.canShowBadge)

        perm.setCanShowBadge(true)
        #expect(perm.canShowBadge)
    }

    @Test
    func notificationPermissionCanPlaySoundWhenToggled() {
        var perm = NotificationPermission.default
        perm.setCanPlaySound(false)
        #expect(!perm.canPlaySound)

        perm.setCanPlaySound(true)
        #expect(perm.canPlaySound)
    }

    @Test(arguments: [NotificationPermission.AlertType.normal, .critical, .timeSensitive])
    func notificationPermissionCanSendAlertTypeWhenToggled(alertType: NotificationPermission.AlertType) {
        var perm = NotificationPermission.default
        perm.setCanSendAlertType(alertType, newValue: false)
        #expect(!perm.canSendAlertType(alertType))

        perm.setCanSendAlertType(alertType, newValue: true)
        #expect(perm.canSendAlertType(alertType))
    }
}