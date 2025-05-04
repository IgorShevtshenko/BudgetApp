// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Services",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Services",
            targets: ["BudgetService"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain")
    ],
    targets: [
        .target(
            name: "BudgetService",
            dependencies: [
                .product(name: "Domain", package: "Domain")
            ]
        ),
    ]
)
