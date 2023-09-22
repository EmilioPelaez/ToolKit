// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ToolKit",
	platforms: [.iOS(.v16), .tvOS(.v16), .macOS(.v13), .watchOS(.v9), .visionOS(.v1), ],
	products: [
		.library(
			name: "ToolKit",
			targets: ["ToolKit"]),
		.library(
			name: "UIToolKit",
			targets: ["UIToolKit"])
	],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.target(name: "ToolKit"),
		.target(name: "UIToolKit"),
		.testTarget(
			name: "ToolKitTests",
			dependencies: ["ToolKit"]),
	]
)
