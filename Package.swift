// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var packageDependencies: [Package.Dependency] = [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
]

#if os(Linux)

packageDependencies += [
    .package(url: "https://github.com/indisoluble/CLapacke-Linux", from: "1.0.0"),
]

#endif

let package = Package(
    name: "EigenSwiftDemo",
    dependencies: packageDependencies,
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "EigenSwiftDemo",
            dependencies: []),
    ]
)
