import DependencyPlugin
import EnvironmentPlugin
import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let configurations: [Configuration] =
    [
        .debug(name: .dev, xcconfig: .shared),
        .debug(name: .stage, xcconfig: .shared),
        .release(name: .prod, xcconfig: .shared)
    ]

let settings: Settings =
    .settings(base: env.baseSetting,
              configurations: configurations,
              defaultSettings: .recommended)

let scripts: [TargetScript] = [.swiftLint]

let targets: [Target] = [
    .init(
        name: env.name,
        platform: env.platform,
        product: .app,
        bundleId: "\(env.organizationName).\(env.name)",
        deploymentTarget: env.deploymentTarget,
        infoPlist: .file(path: "Support/Info.plist"),
        sources: ["Sources/**"],
        resources: ["Resources/**", "Support/GoogleService-Info.plist"],
        scripts: scripts,
        dependencies: [
            .SPM.FirebaseAnalytics,
            .core(target: .CoreKit),
            .core(target: .Networking),
            .domain(target: .CategoryDomain),
            .feature(target: .RootFeature),
            .feature(target: .LaunchScreenFeature),
            .feature(target: .MainTabFeature),
            .feature(target: .HomeFeature),
            .feature(target: .CategoryFeature),
            .feature(target: .LivingFeature),
            .feature(target: .SearchFeature),
            .feature(target: .ProductDetailFeature),
            .feature(target: .SettingsFeature)
        ],
        settings: .settings(base: env.baseSetting)
    )
]

let schemes: [Scheme] = [
    .init(
        name: "\(env.name)-DEV",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .dev),
        archiveAction: .archiveAction(configuration: .dev),
        profileAction: .profileAction(configuration: .dev),
        analyzeAction: .analyzeAction(configuration: .dev)
    ),
    .init(
        name: "\(env.name)-STAGE",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .stage),
        archiveAction: .archiveAction(configuration: .stage),
        profileAction: .profileAction(configuration: .stage),
        analyzeAction: .analyzeAction(configuration: .stage)
    ),
    .init(
        name: "\(env.name)-PROD",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .prod),
        archiveAction: .archiveAction(configuration: .prod),
        profileAction: .profileAction(configuration: .prod),
        analyzeAction: .analyzeAction(configuration: .prod)
    )
]

let project = Project(
    name: env.name,
    organizationName: env.organizationName,
    settings: settings,
    targets: targets,
    schemes: schemes
)
