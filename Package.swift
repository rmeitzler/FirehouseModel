// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirehouseModel",
    platforms: [
            .macOS(.v10_15), .iOS(.v13)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FirehouseModel",
            targets: ["FirehouseModel"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/rmeitzler/XMLTree", from: "1.1.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FirehouseModel",
            dependencies: ["XMLTree"],
            sources: [
              "DefaultOption.swift",
              "Layout.swift",
              "MenuItem.swift",
              "Option.swift",
              "PizzaConfig.swift",
              "SalesGroups.swift",
              "Submenu.swift",
              "Entry.swift",
              "Menu.swift",
              "MenuItemInclusion.swift",
              "OptionGroup.swift",
              "QuickCombos.swift",
              "SalesItem.swift",
              "SubmenuInclusion.swift",
              "Group.swift",
              "MenuInclusion.swift",
              "ModifierAction.swift",
              "OptionSet.swift",
              "Restriction.swift",
              "SalesItemOption.swift",
              "SubmenuInfo.swift"
            ]),
        .testTarget(
            name: "FirehouseModelTests",
            dependencies: ["FirehouseModel"]),
    ]
)
