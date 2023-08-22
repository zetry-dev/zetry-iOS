//
//  ZentryIcon.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public struct ZentryIcon: View {
    private let icon: DesignSystemImages
    private let foregroundColor: Color.ZentryColorSystem

    public init(_ icon: DesignSystemImages, foregroundColor: Color.ZentryColorSystem = .grayScale(.gray12)) {
        self.icon = icon
        self.foregroundColor = foregroundColor
    }

    public var body: some View {
        icon.swiftUIImage
            .foregroundColor(.zentry(foregroundColor))
    }
}
