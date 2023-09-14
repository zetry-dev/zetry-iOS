//
//  View+GradientModi.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/14.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func gradientBackground(height: CGFloat) -> some View {
        self.modifier(GradientBackgroundModifier(height: height))
    }
}

public struct GradientBackgroundModifier: ViewModifier {
    private let height: CGFloat

    public init(height: CGFloat) {
        self.height = height
    }

    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.39, green: 0.61, blue: 0.75).opacity(0.3), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0), location: 1.00)
                ],
                startPoint: UnitPoint(x: 0.31, y: 0.53),
                endPoint: UnitPoint(x: 0.31, y: 0.87)
            )
            .blur(radius: 1)
            .overlay {
                EllipticalGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.21, green: 0.37, blue: 0.49).opacity(0.3), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0), location: 1.00)
                    ],
                    center: UnitPoint(x: 0.66, y: 0.22)
                )
                .blur(radius: 1)
            }
            .frame(height: height)
            .edgesIgnoringSafeArea(.top)
            content
        }
    }
}
