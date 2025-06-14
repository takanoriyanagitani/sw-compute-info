// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "computer_info",
  platforms: [
    .macOS(.v12)
  ],
  dependencies: [
    .package(path: "../../..")
  ],
  targets: [
    .executableTarget(
      name: "computer_info",
      dependencies: [
        "ComputerInfo"
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
