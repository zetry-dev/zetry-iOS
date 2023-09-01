//
//  HomeView.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import SwiftUI

public struct HomeView: View {
    public let store: StoreOf<HomeStore>

    public init(store: StoreOf<HomeStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack {
                ScrollView {
                    Button("검색하기") {
                        viewStore.send(.routeToSearch)
                    }
                }
            }
        }
    }
}
