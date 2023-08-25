//
//  CategoryView.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct CategoryView: View {
    public let store: StoreOf<CategoryStore>

    public init(store: StoreOf<CategoryStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { _ in
            VStack {
                Text("카테고리")
            }
        }
    }
}
