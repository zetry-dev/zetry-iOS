//
//  ZentryDesignSystem+GrayScale.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public extension Color.ZentryColorSystem {
    enum GrayScale: ZentryColorable {
        case gray0
        case gray1
        case gray2
        case gray3
        case gray4
        case gray5
        case gray6
        case gray7
        case gray8
        case gray9
        case gray10
        case gray11
        case gray12
    }
}

public extension Color.ZentryColorSystem.GrayScale {
    var color: Color {
        switch self {
        case .gray0: return DesignSystemAsset.Gray.gray0.swiftUIColor
        case .gray1: return DesignSystemAsset.Gray.gray1.swiftUIColor
        case .gray2: return DesignSystemAsset.Gray.gray2.swiftUIColor
        case .gray3: return DesignSystemAsset.Gray.gray3.swiftUIColor
        case .gray4: return DesignSystemAsset.Gray.gray4.swiftUIColor
        case .gray5: return DesignSystemAsset.Gray.gray5.swiftUIColor
        case .gray6: return DesignSystemAsset.Gray.gray6.swiftUIColor
        case .gray7: return DesignSystemAsset.Gray.gray7.swiftUIColor
        case .gray8: return DesignSystemAsset.Gray.gray8.swiftUIColor
        case .gray9: return DesignSystemAsset.Gray.gray9.swiftUIColor
        case .gray10: return DesignSystemAsset.Gray.gray10.swiftUIColor
        case .gray11: return DesignSystemAsset.Gray.gray11.swiftUIColor
        case .gray12: return DesignSystemAsset.Gray.gray12.swiftUIColor
        }
    }

    var uiColor: UIColor {
        switch self {
        case .gray0: return DesignSystemAsset.Gray.gray0.color
        case .gray1: return DesignSystemAsset.Gray.gray1.color
        case .gray2: return DesignSystemAsset.Gray.gray2.color
        case .gray3: return DesignSystemAsset.Gray.gray3.color
        case .gray4: return DesignSystemAsset.Gray.gray4.color
        case .gray5: return DesignSystemAsset.Gray.gray5.color
        case .gray6: return DesignSystemAsset.Gray.gray6.color
        case .gray7: return DesignSystemAsset.Gray.gray7.color
        case .gray8: return DesignSystemAsset.Gray.gray8.color
        case .gray9: return DesignSystemAsset.Gray.gray9.color
        case .gray10: return DesignSystemAsset.Gray.gray10.color
        case .gray11: return DesignSystemAsset.Gray.gray11.color
        case .gray12: return DesignSystemAsset.Gray.gray12.color
        }
    }
}
