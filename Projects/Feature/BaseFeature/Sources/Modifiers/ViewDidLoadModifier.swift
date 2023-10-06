//
//  ViewDidLoadModifier.swift
//  BaseFeature
//
//  Created by AllieKim on 2023/10/06.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if !didLoad {
                didLoad = true
                action?()
            }
        }
    }
}
