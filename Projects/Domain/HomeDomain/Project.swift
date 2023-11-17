import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.HomeDomain.rawValue,
    targets: [
        .implements(
            module: .domain(.HomeDomain),
            dependencies: [
                .domain(target: .BaseDomain)
            ]
        ),
        .tests(
            module: .domain(.HomeDomain),
            dependencies: [
                .domain(target: .HomeDomain)
            ]
        )
    ]
)
