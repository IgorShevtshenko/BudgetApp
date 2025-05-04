// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "BudgetFeature",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "BudgetFeature",
            targets: ["BudgetFeature"]
        ),
    ],
    dependencies: [
        .package(path: "../ArchitectureKit"),
        .package(path: "../Domain"),
        .package(path: "../Services"),
    ],
    targets: [
        .target(
            name: "BudgetFeature",
            dependencies: [
                .product(name: "ArchitectureKit", package: "ArchitectureKit"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "Services", package: "Services"),
            ]
        ),
        .testTarget(
            name: "BudgetFeatureTests",
            dependencies: [
                "BudgetFeature",
                .product(name: "Domain", package: "Domain"),
                .product(name: "Services", package: "Services"),
            ]
        ),
    ]
)
