// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "ServicesImpl",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ServicesImpl",
            targets: ["BudgetServiceImpl"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Services"),
    ],
    targets: [
        .target(
            name: "BudgetServiceImpl",
            dependencies: [
                .product(name: "Services", package: "Services"),
                .product(name: "Domain", package: "Domain")
            ]
        ),
    ]
)
