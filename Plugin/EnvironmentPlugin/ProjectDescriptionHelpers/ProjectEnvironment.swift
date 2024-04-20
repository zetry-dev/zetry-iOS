import ProjectDescription

public struct ProjectEnvironment {
    public let name: String
    public let organizationName: String
    public let deploymentTarget: DeploymentTargets
    public let destinations: Destinations
    public let baseSetting: SettingsDictionary
}

public let env = ProjectEnvironment(
    name: "Zetry",
    organizationName: "com.zetry",
    deploymentTarget: .iOS("17.0"),
    destinations: Set([.iPhone]),
)
