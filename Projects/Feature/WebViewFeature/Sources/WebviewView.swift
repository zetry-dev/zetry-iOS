//
//  WebviewView.swift
//  WebViewFeature
//
//  Created by Allie Kim on 2023/11/16.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct WebviewView: View {
    public let store: StoreOf<WebviewStore>

    public init(store: StoreOf<WebviewStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack(spacing: 0) {
                ZetryWebView(urlString: viewStore.urlString)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewStore.send(.pop)
                    } label: {
                        ZetryIcon(DesignSystemAsset.Icons.chevronLeft)
                    }
                }
            }
        }
    }
}
