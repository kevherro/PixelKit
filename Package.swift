// swift-tools-version: 6.0

//===----------------------------------------------------------------------===//
//
// This source file is part of the PixelKit open source project
//
// Copyright (c) 2024 Kevin Herro
// Licensed under MIT
//
// See LICENSE.txt for license information
//
// SPDX-License-Identifier: MIT
//
//===----------------------------------------------------------------------===//

import PackageDescription

let package = Package(
  name: "PixelKit",
  platforms: [.macOS(.v15), .iOS(.v17)],
  products: [
    .library(
      name: "PixelKit",
      targets: ["PixelKit"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
  ],
  targets: [
    .target(
      name: "PixelKit"
    ),
  ]
)
