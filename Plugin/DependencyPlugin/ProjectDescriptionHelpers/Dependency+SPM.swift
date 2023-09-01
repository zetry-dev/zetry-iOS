import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let Firestore = TargetDependency.external(name: "FirebaseFirestore")
    static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalyticsWithoutAdIdSupport")
    static let TCACoordinator = TargetDependency.external(name: "TCACoordinators")
    static let TCA = TargetDependency.external(name: "ComposableArchitecture")
}

public extension Package {}
