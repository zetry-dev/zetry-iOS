import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.LivingDomain.rawValue,
    targets: [
        .interface(module: .domain(.LivingDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.LivingDomain), dependencies: [
            .domain(target: .LivingDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .tests(module: .domain(.LivingDomain), dependencies: [
            .domain(target: .LivingDomain),
            .domain(target: .LivingDomain, type: .testing)
        ]),
        .testing(module: .domain(.LivingDomain), dependencies: [
            .domain(target: .LivingDomain, type: .interface)
        ])
    ]
)
