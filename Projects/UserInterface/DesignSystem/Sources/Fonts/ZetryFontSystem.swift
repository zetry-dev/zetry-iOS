//
//  ZetryFontSystem.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension Font.ZetryFontSystem {
    var font: Font {
        switch self {
        case .headline1:
            return DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 26)
        case .headline2:
            return DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 24)
        case .headline3:
            return DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 22)
        case .subtitle1:
            return DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 20)
        case .subtitle2:
            return DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 18)
        case .subtitle3:
            return DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 17)
        case .subtitle4:
            return DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 16)
        case .subtitle5:
            return DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 14)
        case .boldSubtitle1:
            return DesignSystemFontFamily.Pretendard.bold.swiftUIFont(size: 20)
        case .body1:
            return DesignSystemFontFamily.Pretendard.medium.swiftUIFont(size: 17)
        case .body2:
            return DesignSystemFontFamily.Pretendard.medium.swiftUIFont(size: 16)
        case .body3:
            return DesignSystemFontFamily.Pretendard.medium.swiftUIFont(size: 14)
        case .body4:
            return DesignSystemFontFamily.Pretendard.medium.swiftUIFont(size: 12)
        case .body5:
            return DesignSystemFontFamily.Pretendard.medium.swiftUIFont(size: 11)
        case .label1:
            return DesignSystemFontFamily.Pretendard.regular.swiftUIFont(size: 16)
        case .label2:
            return DesignSystemFontFamily.Pretendard.regular.swiftUIFont(size: 14)
        case .label3:
            return DesignSystemFontFamily.Pretendard.regular.swiftUIFont(size: 12)
        case .label4:
            return DesignSystemFontFamily.Pretendard.regular.swiftUIFont(size: 11)
        case .label5:
            return DesignSystemFontFamily.Pretendard.regular.swiftUIFont(size: 10)
        }
    }

    var uiFont: UIFont {
        switch self {
        case .headline1:
            return DesignSystemFontFamily.Pretendard.semiBold.font(size: 26)
        case .headline2:
            return DesignSystemFontFamily.Pretendard.semiBold.font(size: 24)
        case .headline3:
            return DesignSystemFontFamily.Pretendard.semiBold.font(size: 22)
        case .subtitle1:
            return DesignSystemFontFamily.Pretendard.semiBold.font(size: 20)
        case .subtitle2:
            return DesignSystemFontFamily.Pretendard.semiBold.font(size: 18)
        case .subtitle3:
            return DesignSystemFontFamily.Pretendard.semiBold.font(size: 17)
        case .subtitle4:
            return DesignSystemFontFamily.Pretendard.semiBold.font(size: 16)
        case .subtitle5:
            return DesignSystemFontFamily.Pretendard.semiBold.font(size: 14)
        case .boldSubtitle1:
            return DesignSystemFontFamily.Pretendard.bold.font(size: 20)
        case .body1:
            return DesignSystemFontFamily.Pretendard.medium.font(size: 17)
        case .body2:
            return DesignSystemFontFamily.Pretendard.medium.font(size: 16)
        case .body3:
            return DesignSystemFontFamily.Pretendard.medium.font(size: 14)
        case .body4:
            return DesignSystemFontFamily.Pretendard.medium.font(size: 12)
        case .body5:
            return DesignSystemFontFamily.Pretendard.medium.font(size: 11)
        case .label1:
            return DesignSystemFontFamily.Pretendard.regular.font(size: 16)
        case .label2:
            return DesignSystemFontFamily.Pretendard.regular.font(size: 14)
        case .label3:
            return DesignSystemFontFamily.Pretendard.regular.font(size: 12)
        case .label4:
            return DesignSystemFontFamily.Pretendard.regular.font(size: 11)
        case .label5:
            return DesignSystemFontFamily.Pretendard.regular.font(size: 10)
        }
    }
}
