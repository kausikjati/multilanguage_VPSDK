// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "VPSDK",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "VPSDK", targets: ["VPSDK"])
    ],
    targets: [
        .target(
            name: "VPSDK",
            path: "Sources/VPSDK"
        )
    ]
)
