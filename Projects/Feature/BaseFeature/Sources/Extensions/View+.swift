//
//  View+.swift
//  BaseFeature
//
//  Created by AllieKim on 2023/10/06.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
