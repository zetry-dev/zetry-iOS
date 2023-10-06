import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.SettingsDomain.rawValue,
    targets: [
        .interface(
            module: .domain(.SettingsDomain),
            dependencies: [
                .domain(target: .BaseDomain, type: .interface)
            ]
        ),
        .implements(
            module: .domain(.SettingsDomain),
            dependencies: [
                .domain(target: .SettingsDomain, type: .interface),
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
