//
//  TabItemView.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct TabItemView: View {
    @Binding private var selection: MainTabItem
    private var tab: MainTabItem

    public init(selection: Binding<MainTabItem>, tab: MainTabItem) {
        self._selection = selection
        self.tab = tab
    }

    public var body: some View {
        Button {
            selection = tab
        } label: {
            VStack(spacing: 4) {
                let image = tab == selection ? tab.activeIcon.swiftUIImage : tab.defaultIcon.swiftUIImage

                image
                Text(tab.description)
                    .fontStyle(.label4, foregroundColor: .grayScale(selection == tab ? .gray12 : .gray6))
            }
        }
        .buttonStyle(.bounce)
        .frame(maxWidth: .infinity)
    }
}
