import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.BaseDomain.rawValue,
    targets: [
        .interface(
            module: .domain(.BaseDomain),
            dependencies: [
                .core(target: .Networking, type: .interface)
            ]
        ),
        .implements(
            module: .domain(.BaseDomain),
            dependencies: [
                .SPM.TCA,
                .domain(target: .BaseDomain, type: .interface),
                .core(target: .Networking)
            ]
        ),
        .tests(
            module: .domain(.BaseDomain),
            dependencies: [
                .domain(target: .BaseDomain)
            ]
        )
    ]
)
