//
//  ProductDetailView.swift
//  ProductDetailFeature
//
//  Created by AllieKim on 2023/08/29.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct ProductDetailView: View {
    public let store: StoreOf<ProductDetailStore>

    public init(store: StoreOf<ProductDetailStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { _ in
            Text("Detail View")
        }
    }
}
