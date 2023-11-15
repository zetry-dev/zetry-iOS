import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.WebViewFeature.rawValue,
    targets: [
        .implements(
            module: .feature(.WebViewFeature),
            dependencies: [
                .feature(target: .BaseFeature)
            ]
        )
    ]
)
