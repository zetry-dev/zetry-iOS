import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.SettingsDomain.rawValue,
    targets: [
        .implements(
            module: .domain(.SettingsDomain),
            dependencies: [
                .domain(target: .BaseDomain)
            ]
        ),
        .tests(
            module: .domain(.SettingsDomain),
            dependencies: [
                .domain(target: .SettingsDomain)
            ]
        )
    ]
)
