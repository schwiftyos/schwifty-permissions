
@testable import SchwiftyPermissions
import Testing

@Suite
struct DiskPermissionTests {
}

// MARK: Defaults
extension DiskPermissionTests {
    @Test
    func diskPermissionDefaultsCanRead() {
        #expect(DiskPermission.default.canRead)
    }

    @Test
    func diskPermissionDefaultsCanReadPathWhenInForeground() {
        #expect(DiskPermission.default.canPerform(action: .read("/home/user"), state: .foreground))
    }
    @Test
    func diskPermissionDefaultsCanReadPathWhenInBackground() {
        #expect(DiskPermission.default.canPerform(action: .read("/home/user"), state: .background))
    }
    @Test
    func diskPermissionDefaultsCanReadPathWhenNotRunning() {
        #expect(DiskPermission.default.canPerform(action: .read("/home/user"), state: .notRunning))
    }


    @Test
    func diskPermissionDefaultsCanWrite() {
        #expect(DiskPermission.default.canWrite)
    }
    @Test
    func diskPermissionDefaultsCanWritePathWhenInForeground() {
        #expect(DiskPermission.default.canPerform(action: .read("/home/user"), state: .foreground))
    }

    @Test
    func diskPermissionDefaultsCanWritePathWhenInBackground() {
        #expect(DiskPermission.default.canPerform(action: .read("/home/user"), state: .background))
    }

    @Test
    func diskPermissionDefaultsCanWritePathWhenNotRunning() {
        #expect(DiskPermission.default.canPerform(action: .read("/home/user"), state: .notRunning))
    }
}

// MARK: Read
extension DiskPermissionTests {
    @Test
    func diskPermissionCannotReadWhenRevoked() {
        var perm = DiskPermission.default
        perm.setCanRead(false)
        #expect(!perm.canPerform(action: .read("/home/user"), state: .foreground))
    }
}

// MARK: Write
extension DiskPermissionTests {
    @Test
    func diskPermissionCannotWriteWhenRevoked() {
        var perm = DiskPermission.default
        perm.setCanWrite(false)
        #expect(!perm.canPerform(action: .write("/home/user"), state: .foreground))
    }
}