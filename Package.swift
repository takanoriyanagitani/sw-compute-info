// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "sw-compute-info",
  platforms: [
    .macOS(.v12)
  ],
  products: [
    .library(
      name: "ComputerInfo",
      targets: ["ComputerInfo"])
  ],
  dependencies: [
    .package(url: "https://github.com/realm/SwiftLint", from: "0.59.1")
  ],
  targets: [
    .target(
      name: "ComputerInfo"
    ),
    .testTarget(
      name: "ComputerInfoTests",
      dependencies: ["ComputerInfo"]
    ),
  ]
)
