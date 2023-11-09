import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.HomeDomain.rawValue,
    targets: [
        .interface(
            module: .domain(.HomeDomain),
            dependencies: [
                .domain(target: .BaseDomain, type: .interface)
            ]
        ),
        .implements(
            module: .domain(.HomeDomain),
            dependencies: [
                .domain(target: .HomeDomain, type: .interface),
                .domain(target: .BaseDomain)
            ]
        ),
        .testing(
            module: .domain(.HomeDomain),
            dependencies: [
                .domain(target: .HomeDomain, type: .interface)
            ]
        ),
        .tests(
            module: .domain(.HomeDomain),
            dependencies: [
                .domain(target: .HomeDomain),
                .domain(target: .HomeDomain, type: .testing)
            ]
        )
    ]
)
