import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.CategoryFeature.rawValue,
    targets: [
        .implements(
            module: .feature(.CategoryFeature),
            dependencies: [
                .feature(target: .BaseFeature),
                .feature(target: .SearchFeature),
                .domain(target: .CategoryDomain),
                .domain(target: .ProductDomain)
            ]
        ),
        .tests(
            module: .feature(.CategoryFeature),
            dependencies: [
                .feature(target: .CategoryFeature),
                .domain(target: .CategoryDomain),
                .domain(target: .ProductDomain)
            ]
        ),
        .demo(
            module: .feature(.CategoryFeature),
            dependencies: [
                .feature(target: .CategoryFeature),
                .domain(target: .CategoryDomain),
                .domain(target: .ProductDomain)
            ]
        ),
    ]
)
