// swift-tools-version:6.0

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "schwifty-permissions",
    products: [
        .library(
            name: "SchwiftyPermissions",
            targets: ["SchwiftyPermissions"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SchwiftyPermissions",
            dependencies: []
        ),
        .testTarget(
            name: "SchwiftyPermissionsTests",
            dependencies: [
                "SchwiftyPermissions"
            ]
        )
    ]
)
