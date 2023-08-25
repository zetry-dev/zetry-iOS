//
//  ZetryIcon.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct ZetryIcon: View {
    public enum Size {
        case larger
        case smaller
        case custom(CGSize)
    }

    private let icon: DesignSystemImages
    private let foregroundColor: Color.ZetryColorSystem
    private let size: ZetryIcon.Size

    public init(
        _ icon: DesignSystemImages,
        foregroundColor: Color.ZetryColorSystem = .grayScale(.gray12),
        size: ZetryIcon.Size = .smaller
    ) {
        self.icon = icon
        self.foregroundColor = foregroundColor
        self.size = size
    }

    public var body: some View {
        icon.swiftUIImage
            .resizable()
            .frame(width: size.width, height: size.height)
            .foregroundColor(.zetry(foregroundColor))
    }
}

extension ZetryIcon.Size {
    var width: CGFloat {
        switch self {
        case .larger:
            return 24
        case .smaller:
            return 20
        case .custom(let size):
            return size.width
        }
    }

    var height: CGFloat {
        switch self {
        case .larger:
            return 24
        case .smaller:
            return 20
        case .custom(let size):
            return size.height
        }
    }
}
