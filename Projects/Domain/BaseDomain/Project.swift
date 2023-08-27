import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.BaseDomain.rawValue,
    targets: [
        .interface(module: .domain(.BaseDomain)),
        .implements(
            module: .domain(.BaseDomain),
            dependencies: [
                .SPM.TCA,
                .domain(target: .BaseDomain, type: .interface),
                .core(target: .Networking),
                .shared(target: .GlobalThirdPartyLibrary)
//                .shared(target: .UtilityModule)
            ]
        ),
        .tests(module: .domain(.BaseDomain), dependencies: [
            .domain(target: .BaseDomain)
        ])
    ]
)
