import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let Firestore = TargetDependency.external(name: "FirebaseFirestore")
    static let FirestoreSwift = TargetDependency.external(name: "FirebaseFirestoreSwift")
    static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalyticsWithoutAdIdSupport")
    static let TCACoordinator = TargetDependency.external(name: "TCACoordinators")
    static let TCA = TargetDependency.external(name: "ComposableArchitecture")
}

public extension Package {}
