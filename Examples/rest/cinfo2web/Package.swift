// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "cinfo2web",
  platforms: [
    .macOS(.v14)
  ],
  dependencies: [
    .package(path: "../../.."),
    .package(
      url: "https://github.com/hummingbird-project/hummingbird", from: "2.0.0",
    ),
  ],
  targets: [
    .executableTarget(
      name: "cinfo2web",
      dependencies: [
        "ComputerInfo",
        .product(name: "Hummingbird", package: "hummingbird"),
      ],
      swiftSettings: [
        .unsafeFlags(
          ["-cross-module-optimization"],
          .when(configuration: .release),
        )
      ],
    )
  ]
)
