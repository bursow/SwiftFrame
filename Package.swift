// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "SwiftFrame",
    platforms: [
        .iOS(.v15), .macOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftFrame",
            targets: ["SwiftFrame"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftFrame",
            dependencies: [],
            linkerSettings: [
                .linkedFramework("Accelerate") // 💥 EKLENDİ
            ]
        ),
        .testTarget(
            name: "SwiftFrameTests",
            dependencies: ["SwiftFrame"]
        ),
    ]
)
