import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.Networking.rawValue,
    targets: [
        .interface(module: .core(.Networking)),
        .implements(module: .core(.Networking), dependencies: [
            .SPM.Firestore,
            .core(target: .Networking, type: .interface)
        ]),
        .tests(module: .core(.Networking), dependencies: [
            .core(target: .Networking)
        ])
    ]
)
