// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v14), .macOS(.v10_15)],
  products: [
    .library(
      name: "Core",
      targets: ["Core"]),
  ],
  dependencies: [
    .package(url: "https://github.com/exyte/ActivityIndicatorView.git", from: "0.0.1"),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0")),
  ],
  targets: [
    .target(
      name: "Core",
      dependencies: [
        "Alamofire",
        "ActivityIndicatorView"
      ]
    ),
  ]
)
