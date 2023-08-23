//
//  ZentryIcon.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public struct ZentryIcon: View {
    public enum Size {
        case larger
        case smaller
        case custom(CGSize)
    }

    private let icon: DesignSystemImages
    private let foregroundColor: Color.ZentryColorSystem
    private let size: ZentryIcon.Size

    public init(
        _ icon: DesignSystemImages,
        foregroundColor: Color.ZentryColorSystem = .grayScale(.gray12),
        size: ZentryIcon.Size = .smaller
    ) {
        self.icon = icon
        self.foregroundColor = foregroundColor
        self.size = size
    }

    public var body: some View {
        icon.swiftUIImage
            .resizable()
            .frame(width: size.width, height: size.height)
            .foregroundColor(.zentry(foregroundColor))
    }
}

extension ZentryIcon.Size {
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
