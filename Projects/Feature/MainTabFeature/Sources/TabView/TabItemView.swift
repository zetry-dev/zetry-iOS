//
//  TabItemView.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

//public struct TabItemView: View {
//    @Binding private var selection: MainTabItem
//    private var tab: MainTabItem
//
//    public init(selection: Binding<MainTabItem>, tab: MainTabItem) {
//        self._selection = selection
//        self.tab = tab
//    }
//
//    public var body: some View {
//        VStack(spacing: 4) {
//            Image(systemName: tab.icon)
//                .renderingMode(.template)
//                .foregroundColor(selection == tab ? Color.black : Color.gray)
//            Text(tab.description)
//                .foregroundColor(selection == tab ? Color.black : Color.gray)
//        }
//        .onTapGesture {
//            selection = tab
//        }
//        .frame(maxWidth: .infinity)
//    }
//}
