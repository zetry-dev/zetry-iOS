//
//  SettingsView.swift
//  SettingsFeature
//
//  Created by AllieKim on 2023/08/31.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct SettingsView: View {
    public let store: StoreOf<SettingsStore>

    public init(store: StoreOf<SettingsStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack(spacing: 0) {
                List(viewStore.listItems, id: \.title) { item in
                    listItemView(with: viewStore, item: item)
                        .onTapGesture {
                            print("hi!")
                            if let urlString = item.urlString,
                               let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                }
                .listStyle(.plain)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("설정")
                        .fontStyle(.subtitle2)
                }
            }
            .onLoad {
                viewStore.send(.onLoad)
            }
        }
    }

    @ViewBuilder
    private func listItemView(with viewStore: ViewStoreOf<SettingsStore>, item: SettingItem) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(item.title)
                    .fontStyle(.body2)
                    .padding(.vertical, 16)
                Spacer()

                if let _ = item.urlString {
                    ZetryIcon(
                        DesignSystemAsset.Icons.chevronRight,
                        foregroundColor: .grayScale(.gray3)
                    )
                } else {
                    if viewStore.updateNeeded {
                        Button {
                            if let url = URL(string: "itms-apps://itunes.apple.com/app/id6472266915"),
                               UIApplication.shared.canOpenURL(url)
                            {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        } label: {
                            Text("업데이트")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                        }
                        .buttonStyle(.capsule)
                    }
                }
            }
            Divider(color: .grayScale(.gray0))
        }
        .padding(.horizontal, 16)
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
    }
}
