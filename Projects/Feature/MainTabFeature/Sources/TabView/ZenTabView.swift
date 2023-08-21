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
    @Binding private var selectedTab: MainTabItem

    public init(selectedTab: Binding<MainTabItem>) {
        self._selectedTab = selectedTab
    }

    public var body: some View {
        HStack {
            TabItemView(selection: $selectedTab, tab: .home)
            TabItemView(selection: $selectedTab, tab: .category)
            TabItemView(selection: $selectedTab, tab: .living)
        }
        .frame(maxHeight: 64, alignment: .center)
        .overlay(alignment: .top) {
            Color.gray.frame(height: 1, alignment: .top)
        }
    }
}

struct CustomTabBarContainerView<Content: View>: View {
    @Binding var selection: MainTabItem
    let content: Content
    @State private var tabs: [MainTabItem] = []

    init(selection: Binding<MainTabItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        } //: ZSTACK
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct CustomTabBarView: View {
    let tabs: [MainTabItem]
    @Binding var selection: MainTabItem
    @Namespace private var namespace
    @State var localSelection: MainTabItem

    var body: some View {
        tabBarVersion1
            .onChange(of: selection) { newValue in
                withAnimation(.easeInOut) {
                    localSelection = newValue
                }
            }
    }
}

extension CustomTabBarView {
    private func tabView(tab: MainTabItem) -> some View {
        VStack {
            Image(systemName: tab.icon)
                .font(.subheadline)
            Text(tab.description)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        } //: VSTACK
        .foregroundColor(selection == tab ? Color.red : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(selection == tab ? Color.red.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }

    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        } //: HSTACK
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
    }

    private func switchToTab(tab: MainTabItem) {
        selection = tab
    }
}

struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [MainTabItem] = []

    static func reduce(value: inout [MainTabItem], nextValue: () -> [MainTabItem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier: ViewModifier {
    let tab: MainTabItem
    @Binding var selection: MainTabItem

    func body(content: Content) -> some View {
        content
//            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(tab: MainTabItem, selection: Binding<MainTabItem>) -> some View {
        self
            .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
