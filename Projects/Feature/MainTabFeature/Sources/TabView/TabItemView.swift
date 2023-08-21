//
//  TabItemView.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct TabItemView: View {
    private var selection: ViewStore<MainTabItem, MainTabCore.Action>
    private var tab: MainTabItem

    public init(selection: ViewStore<MainTabItem, MainTabCore.Action>, tab: MainTabItem) {
        self.selection = selection
        self.tab = tab
    }

    public var body: some View {
        VStack(spacing: 4) {
            Image(systemName: tab.icon)
                .renderingMode(.template)
                .foregroundColor(selection.state == tab ? Color.black : Color.gray)
            Text(tab.description)
                .foregroundColor(selection.state == tab ? Color.black : Color.gray)
        }
        .onTapGesture {
            selection.send(.tabSelected(tab))
        }
        .frame(maxWidth: .infinity)
    }
}
