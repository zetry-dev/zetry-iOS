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
                List(viewStore.listItems, id: \.title) {
                    listItemView(with: viewStore, item: $0)
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
                viewStore.send(.didLoad)
            }
        }
    }

    @ViewBuilder
    private func listItemView(with viewStore: ViewStoreOf<SettingsStore>, item: SettingItem) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(item.title)
                    .fontStyle(.body1)
                    .padding(16)
                Spacer()

                if let url = item.url {
                    ZetryIcon(
                        DesignSystemAsset.Icons.chevronRight,
                        foregroundColor: .grayScale(.gray3)
                    )
                    .padding(.trailing, 16)
                } else {
                    if viewStore.updateNeeded {
                        Button("업데이트") {
                            //
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .buttonStyle(.capsule)
                    }
                }
            }
            Divider()
        }
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
    }
}
