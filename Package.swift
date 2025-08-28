// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ExyteMediaPicker",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ExyteMediaPicker",
            targets: ["ExyteMediaPicker"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/InspireDevStdio/ExyteAnchoredPopup.git",
            from: "1.0.0"
        )
    ],
    targets: [
        .target(
            name: "ExyteMediaPicker",
            dependencies: [
                .product(name: "ExyteAnchoredPopup", package: "ExyteAnchoredPopup")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "MediaPickerTests",
            dependencies: ["ExyteMediaPicker"]),
    ]
)
