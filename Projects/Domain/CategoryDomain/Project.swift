import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.CategoryDomain.rawValue,
    targets: [
        .implements(
            module: .domain(.CategoryDomain),
            dependencies: [
                .domain(target: .BaseDomain)
            ]
        ),
        .tests(
            module: .domain(.CategoryDomain),
            dependencies: [
                .domain(target: .CategoryDomain)
            ]
        )
    ]
)
