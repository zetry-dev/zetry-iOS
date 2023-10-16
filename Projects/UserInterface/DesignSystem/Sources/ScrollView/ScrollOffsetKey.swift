//
//  ScrollOffsetKey.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/16.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct ScrollOffsetKey: PreferenceKey {
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
