import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.ProductDomain.rawValue,
    targets: [
        .implements(
            module: .domain(.ProductDomain),
            dependencies: [
                .domain(target: .BaseDomain)
            ]
        ),
        .tests(
            module: .domain(.ProductDomain),
            dependencies: [
                .domain(target: .ProductDomain)
            ]
        )
    ]
)
