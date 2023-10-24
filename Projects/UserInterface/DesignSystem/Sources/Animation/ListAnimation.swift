//
//  ListAnimation.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/05.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func animatedList(_ isAnimated: Bool, index: Int, _ delay: Double = 0.3) -> some View {
        self
            .opacity(isAnimated ? 1 : 0)
            .offset(CGSize(width: 0, height: isAnimated ? 0 : 10))
            .animation(.easeInOut(duration: delay * Double(index + 2)).delay(0.2), value: isAnimated)
    }
}
