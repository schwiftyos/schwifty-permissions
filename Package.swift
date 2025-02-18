// swift-tools-version:6.0

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "schwifty-permissions",
    products: [
        .library(
            name: "SchwiftyPermissions",
            type: .dynamic,
            targets: ["SchwiftyPermissions"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SchwiftyPermissions",
            dependencies: [],
            swiftSettings: [
                .unsafeFlags(["-enable-library-evolution"])
            ]
        ),
        .testTarget(
            name: "SchwiftyPermissionsTests",
            dependencies: [
                "SchwiftyPermissions"
            ]
        )
    ]
)
