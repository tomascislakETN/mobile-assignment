// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Presentation",
  platforms: [.iOS(.v17)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "RocketList",
      targets: ["RocketList"]
    ),
    .library(
      name: "RocketDetail",
      targets: ["RocketDetail"]
    )
  ],
  dependencies: [
    .package(path: "../Infrastructure"),
    .package(path: "../Domain"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.0.0"))
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "RocketList",
      dependencies: [
        "RocketDetail",
        .product(name: "UIToolkit", package: "Infrastructure"),
        .product(name: "SpaceSDK", package: "Domain"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .target(
      name: "RocketDetail",
      dependencies: [
        .product(name: "Motion", package: "Infrastructure"),
        .product(name: "UIToolkit", package: "Infrastructure"),
        .product(name: "SpaceSDK", package: "Domain"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "RocketListTests",
      dependencies: ["RocketList"]
    )
  ]
)
