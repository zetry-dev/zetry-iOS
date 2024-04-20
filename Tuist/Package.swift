// swift-tools-version: 5.9
//  Package.swift
//  Config
//
//  Created by Allie Kim on 4/20/24.
//

import PackageDescription

#if TUIST
import ConfigurationPlugin
import struct ProjectDescription.PackageSettings

let packageSettings = PackageSettings(
    //    productTypes: [
//        "CoreKit": .framework,
//        "LaunchScreenFeature": .framework,
//        "ProductDomain": .framework,
//        "TCACoordinators": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//        "CoreKit": .framework,
//
//    ],
    baseSettings: .settings(
        configurations: [
            .debug(name: .dev),
            .debug(name: .stage),
            .release(name: .prod),
        ]
    )
)

#endif

let packages = Package(
    name: "Packages",
    dependencies:
    [
        .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.10.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.24.0"),
        .package(url: "https://github.com/johnpatrickmorgan/TCACoordinators.git", exact: "0.6.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.1.0"),
    ]
)
