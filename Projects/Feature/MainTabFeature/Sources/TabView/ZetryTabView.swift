//
//  ZetryTabView.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct ZetryTabView: View {
    @Binding private var selectedTab: MainTabItem

    public init(selectedTab: Binding<MainTabItem>) {
        self._selectedTab = selectedTab
    }

    public var body: some View {
        HStack {
            TabItemView(selection: $selectedTab, tab: .home)
            TabItemView(selection: $selectedTab, tab: .category)
            TabItemView(selection: $selectedTab, tab: .living)
            TabItemView(selection: $selectedTab, tab: .settings)
        }
        .padding(.top, 12)
        .padding(.bottom, 34)
        .background(
            .thinMaterial,
            in: RoundedRectangle(cornerRadius: 15, style: .continuous)
        )
        .shadow(color: .black.opacity(0.12), radius: 3, x: 0, y: 0)
    }
}
