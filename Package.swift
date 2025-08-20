// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

func targets() -> [Target] {
#if SKETCH_USE_SWIFT_MACROS
    return [
        .macro(
            name: "SwiftMCPMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(
            name: "SwiftMCP",
            dependencies: [
                "AnyCodable",
                "SwiftMCPMacros",
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "NIOFoundationCompat", package: "swift-nio"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto"),
                .product(name: "X509", package: "swift-certificates")
            ]
        ),
        .executableTarget(
            name: "SwiftMCPDemo",
            dependencies: [
                "SwiftMCP",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Demos/SwiftMCPDemo"
        ),
        .testTarget(
            name: "SwiftMCPTests",
            dependencies: [
                "SwiftMCP",
                "SwiftMCPMacros",
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto"),
                .product(name: "X509", package: "swift-certificates")
            ]
        )
    ]
#else
    return [
        .target(
            name: "SwiftMCP",
            dependencies: [
                "AnyCodable",
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "NIOFoundationCompat", package: "swift-nio"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto"),
                .product(name: "X509", package: "swift-certificates")
            ]
        ),
        .executableTarget(
            name: "SwiftMCPDemo",
            dependencies: [
                "SwiftMCP",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Demos/SwiftMCPDemo"
        ),
        .testTarget(
            name: "SwiftMCPTests",
            dependencies: [
                "SwiftMCP",
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto"),
                .product(name: "X509", package: "swift-certificates")
            ]
        )
    ]
#endif
}

func dependencies() -> [Package.Dependency] {
    var dependencies: [Package.Dependency] = [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/Flight-School/AnyCodable", from: "0.6.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.0.0"),
        .package(url: "https://github.com/apple/swift-certificates.git", from: "1.1.0")
    ]
#if SKETCH_USE_SWIFT_MACROS
    dependencies.append(.package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0-latest"))
#endif
    return dependencies
}

let package = Package(
	name: "SwiftMCP",
	platforms: [
		.macOS("11.0"),
		.iOS("14.0"),
		.tvOS("14.0"),
		.watchOS("7.0"),
		.macCatalyst("14.0")
	],
	products: [
		.library(
			name: "SwiftMCP",
			targets: ["SwiftMCP"]
		),
		.executable(
			name: "SwiftMCPDemo",
			targets: ["SwiftMCPDemo"]
		)
	],
    dependencies: dependencies(),
    targets: targets()
)
