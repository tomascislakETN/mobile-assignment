// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Domain",
  platforms: [.iOS(.v17)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "RocketSDK",
      targets: ["RocketSDK"]
    )
  ],
  dependencies: [
    .package(path: "../Infrastructure"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", .upToNextMajor(from: "1.0.0")),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", .upToNextMajor(from: "1.0.0"))
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "RocketSDK",
      dependencies: [
        .product(name: "Motion", package: "Infrastructure"),
        .product(name: "Networking", package: "Infrastructure"),
        .product(name: "CoreToolkit", package: "Infrastructure"),
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    ),
    .testTarget(
      name: "RocketSDKTests",
      dependencies: [
        "RocketSDK",
        .product(name: "CustomDump", package: "swift-custom-dump")
      ]
    )
  ]
)
