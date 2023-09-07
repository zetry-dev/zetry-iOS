import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.ProductDetailFeature.rawValue,
    targets: [
        .implements(
            module: .feature(.ProductDetailFeature),
            dependencies: [
                .feature(target: .BaseFeature),
                .domain(target: .ProductDomain),
                .domain(target: .ProductDomain, type: .interface)
            ]
        ),
        .tests(
            module: .feature(.ProductDetailFeature),
            dependencies: [
                .feature(target: .ProductDetailFeature)
            ]
        ),
        .demo(
            module: .feature(.ProductDetailFeature),
            dependencies: [
                .feature(target: .ProductDetailFeature)
            ]
        )
    ]
)
