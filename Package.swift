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
    .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "10.5.1"),
    .package(url: "https://github.com/exyte/ActivityIndicatorView.git", from: "0.0.1"),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0")),
  ],
  targets: [
    .target(
      name: "Core",
      dependencies: [
        .product(name: "RealmSwift", package: "Realm"),
        "Alamofire",
        "ActivityIndicatorView"
      ]
    ),
  ]
)
