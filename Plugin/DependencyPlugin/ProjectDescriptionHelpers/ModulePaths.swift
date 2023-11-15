import Foundation

// swiftlint: disable all
public enum ModulePaths {
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
    case userInterface(UserInterface)
}

extension ModulePaths: MicroTargetPathConvertable {
    public func targetName(type: MicroTargetType) -> String {
        switch self {
        case let .feature(module as any MicroTargetPathConvertable),
             let .domain(module as any MicroTargetPathConvertable),
             let .core(module as any MicroTargetPathConvertable),
             let .shared(module as any MicroTargetPathConvertable),
             let .userInterface(module as any MicroTargetPathConvertable):
            return module.targetName(type: type)
        }
    }
}

public extension ModulePaths {
    enum Feature: String, MicroTargetPathConvertable {
        case WebViewFeature
        case SettingsFeature
        case ProductDetailFeature
        case SearchFeature
        case LivingFeature
        case CategoryFeature
        case HomeFeature
        case MainTabFeature
        case LaunchScreenFeature
        case RootFeature
        case BaseFeature
    }
}

public extension ModulePaths {
    enum Domain: String, MicroTargetPathConvertable {
        case HomeDomain
        case LivingDomain
        case SettingsDomain
        case ProductDomain
        case CategoryDomain
        case BaseDomain
    }
}

public extension ModulePaths {
    enum Core: String, MicroTargetPathConvertable {
        case Networking
        case CoreKit
    }
}

public extension ModulePaths {
    enum Shared: String, MicroTargetPathConvertable {
        case GlobalThirdPartyLibrary
    }
}

public extension ModulePaths {
    enum UserInterface: String, MicroTargetPathConvertable {
        case DesignSystem
    }
}

public enum MicroTargetType: String {
    case interface = "Interface"
    case sources = ""
    case testing = "Testing"
    case unitTest = "Tests"
    case demo = "Demo"
}

public protocol MicroTargetPathConvertable {
    func targetName(type: MicroTargetType) -> String
}

public extension MicroTargetPathConvertable where Self: RawRepresentable {
    func targetName(type: MicroTargetType) -> String {
        "\(self.rawValue)\(type.rawValue)"
    }
}
