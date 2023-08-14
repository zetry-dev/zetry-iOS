import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Shared.GlobalThirdPartyLibrary.rawValue,
    product: .framework,
    targets: []
)
