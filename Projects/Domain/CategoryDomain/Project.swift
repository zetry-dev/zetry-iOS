import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.CategoryDomain.rawValue,
    targets: [
        .interface(module: .domain(.CategoryDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .domain(.CategoryDomain), dependencies: [
            .domain(target: .CategoryDomain, type: .interface),
            .domain(target: .BaseDomain)
        ]),
        .tests(module: .domain(.CategoryDomain), dependencies: [
            .domain(target: .CategoryDomain),
            .domain(target: .CategoryDomain, type: .testing)
        ]),
        .testing(module: .domain(.CategoryDomain), dependencies: [
            .domain(target: .CategoryDomain, type: .interface)
        ])
    ]
)
