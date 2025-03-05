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
    dependencies: [
        // TODO: add logging library
        // Schwifty Utilities
        .package(url: "https://github.com/schwiftyos/schwifty-utilities", branch: "main")
    ],
    targets: [
        .target(
            name: "SchwiftyPermissions",
            dependencies: [
                .product(name: "SchwiftyUtilities", package: "schwifty-utilities")
            ],
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
