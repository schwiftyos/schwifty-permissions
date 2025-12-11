
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

    @Test(arguments: [ProgramState.foreground, .background, .notRunning])
    func diskPermissionDefaultsCanReadPath(state: ProgramState) {
        #expect(DiskPermission.default.canPerform(action: .read("/home/user"), state: state))
    }


    @Test
    func diskPermissionDefaultsCanWrite() {
        #expect(DiskPermission.default.canWrite)
    }

    @Test(arguments: [ProgramState.foreground, .background, .notRunning])
    func diskPermissionDefaultsCanWritePath(state: ProgramState) {
        #expect(DiskPermission.default.canPerform(action: .write("/home/user"), state: state))
    }
}

// MARK: Read
extension DiskPermissionTests {
    @Test(arguments: [ProgramState.foreground, .background, .notRunning])
    func diskPermissionCannotReadWhenRevoked(state: ProgramState) {
        var perm = DiskPermission.default
        perm.setCanRead(false)
        #expect(!perm.canPerform(action: .read("/home/user"), state: state))
    }

    @Test(arguments: [ProgramState.foreground, .background, .notRunning])
    func diskPermissionCannotReadWhenBlacklisted(state: ProgramState) {
        var perm = DiskPermission.default
        perm.pathReadBlacklist.insert("/home/user2")
        #expect(perm.canPerform(action: .read("/home/user1"), state: state))
        #expect(!perm.canPerform(action: .read("/home/user2"), state: state))
    }
}

// MARK: Write
extension DiskPermissionTests {
    @Test(arguments: [ProgramState.foreground, .background, .notRunning])
    func diskPermissionCannotWriteWhenRevoked(state: ProgramState) {
        var perm = DiskPermission.default
        perm.setCanWrite(false)
        #expect(!perm.canPerform(action: .write("/home/user1"), state: state))
    }

    @Test(arguments: [ProgramState.foreground, .background, .notRunning])
    func diskPermissionCannotWriteWhenBlacklisted(state: ProgramState) {
        var perm = DiskPermission.default
        perm.pathWriteBlacklist.insert("/home/user2")
        #expect(perm.canPerform(action: .write("/home/user1"), state: state))
        #expect(!perm.canPerform(action: .write("/home/user2"), state: state))
    }
}