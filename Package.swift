// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ToolKit",
	platforms: [.iOS(.v16), .tvOS(.v16), .macOS(.v13), .watchOS(.v10)],
	products: [
		.library(
			name: "ToolKit",
			targets: ["ToolKit"]),
		.library(
			name: "UIToolKit",
			targets: ["UIToolKit"]),
		.library(
			name: "AboutKit",
			targets: ["AboutKit"]),
		.library(
			name: "CompatibilityKit",
			targets: ["CompatibilityKit"])
	],
	dependencies: [
		.package(url: "https://github.com/EmilioPelaez/CGMath", from: .init(1, 0, 0)),
		.package(url: "https://github.com/EmilioPelaez/HierarchyResponder", from: .init(1, 0, 0)),
	],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.target(name: "ToolKit"),
		.target(
			name: "UIToolKit",
			dependencies: [
				"CGMath",
				"HierarchyResponder",
				"ToolKit",
			]
		),
		.target(
			name: "AboutKit",
			dependencies: [
				"HierarchyResponder",
				"ToolKit",
				"UIToolKit",
			]
		),
		.target(name: "CompatibilityKit"),
		.testTarget(
			name: "ToolKitTests",
			dependencies: ["ToolKit"]
		),
	]
)
