import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.LivingDomain.rawValue,
    targets: [
        .implements(
            module: .domain(.LivingDomain),
            dependencies: [
                .domain(target: .BaseDomain)
            ]
        ),
        .tests(
            module: .domain(.LivingDomain),
            dependencies: [
                .domain(target: .LivingDomain)
            ]
        )
    ]
)
