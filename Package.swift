// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "string-utils",
  products: [
    .library(name: "RemoveComments", targets: ["RemoveComments"]),
  ],
  targets: [
    .target(
      name: "RemoveComments",
      dependencies: []),
    .testTarget(
      name: "RemoveCommentsTests",
      dependencies: ["RemoveComments"]),
  ]
)
