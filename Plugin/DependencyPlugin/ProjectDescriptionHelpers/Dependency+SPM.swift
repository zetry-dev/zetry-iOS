import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let TCACoordinator = TargetDependency.external(name: "TCACoordinators")
    static let TCA = TargetDependency.external(name: "ComposableArchitecture")
}

public extension Package {
}
