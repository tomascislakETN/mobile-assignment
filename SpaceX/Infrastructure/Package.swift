// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Infrastructure",
  defaultLocalization: "en",
  platforms: [.iOS(.v17)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "UIToolkit",
      targets: ["UIToolkit"]
    ),
    .library(
      name: "Motion",
      targets: ["Motion"]
    ),
    .library(
      name: "CoreToolkit",
      targets: ["CoreToolkit"]
    ),
    .library(
      name: "Networking",
      targets: ["Networking"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", .upToNextMajor(from: "1.0.0")),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "UIToolkit",
      resources: [
        .process("Resources/Sources")
      ]
    ),
    .target(
      name: "Motion",
      dependencies: [
        "CoreToolkit",
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    ),
    .target(
      name: "CoreToolkit"
    ),
    .target(
      name: "Networking",
      dependencies: [
        "CoreToolkit",
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    )
  ]
)
