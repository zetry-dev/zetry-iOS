//
//  ZenTabView.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct ZenTabView: View {
    private var viewStore: ViewStore<MainTabItem, MainTabReducer.Action>

    public init(viewStore: ViewStore<MainTabItem, MainTabReducer.Action>) {
        self.viewStore = viewStore
    }

    public var body: some View {
        HStack {
            TabItemView(selection: viewStore, tab: .home)
            TabItemView(selection: viewStore, tab: .category)
            TabItemView(selection: viewStore, tab: .living)
        }
        .frame(maxHeight: 64, alignment: .center)
        .overlay(alignment: .top) {
            Color.gray.frame(height: 1, alignment: .top)
        }
    }
}
