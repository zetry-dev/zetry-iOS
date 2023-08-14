import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Core.CoreKit.rawValue,
    product: .framework,
    targets: []
)
