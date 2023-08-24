import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.CoreKit.rawValue,
    targets: [
        .interface(module: .core(.CoreKit), dependencies: [
        ]),
        .implements(module: .core(.CoreKit), dependencies: [
        ])
    ]
)
