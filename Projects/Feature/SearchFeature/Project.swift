import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.SearchFeature.rawValue,
    targets: [
        .implements(
            module: .feature(.SearchFeature),
            dependencies: [
                .feature(target: .BaseFeature),
                .domain(target: .CategoryDomain),
                .domain(target: .CategoryDomain, type: .interface),
            ]
        ),
        .tests(
            module: .feature(.SearchFeature),
            dependencies: [
                .feature(target: .SearchFeature)
            ]
        ),
        .demo(
            module: .feature(.SearchFeature),
            dependencies: [
                .feature(target: .SearchFeature)
            ]
        ),
    ]
)
