//
//  SearchView.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct SearchView: View {
    private let store: StoreOf<SearchStore>
    @FocusState private var focusedField: Bool

    public init(store: StoreOf<SearchStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { _ in
            VStack(spacing: 0) {
                searchableNavigationView()
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        Text("추천 검색어")
                            .fontStyle(.subtitle3)
                        Spacer()
                        Button {
                            // TODO: 삭제 액션
                        } label: {
                            Text("전체삭제")
                                .fontStyle(.label2, foregroundColor: .grayScale(.gray7))
                        }
                    }
                    .padding(.top, 20)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0 ..< 10, id: \.self) { _ in
                                Button("종이컵", action: {})
                                    .buttonStyle(.capsule)
                            }
                        }
                        .padding(.vertical, 8)
                    }

                    HStack {
                        Text("이웃들이 많이 찾아봤어요")
                            .fontStyle(.subtitle3)
                        Spacer()
                        Text("2023.08.08 오후 7시 업데이트")
                            .fontStyle(.label4, foregroundColor: .grayScale(.gray7))
                    }
                    .padding(.top, 18)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0 ..< 10, id: \.self) { _ in
                                Button("종이컵", action: {})
                                    .buttonStyle(.capsule)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .padding(.horizontal, 18)
            }
        }
    }

    @MainActor
    @ViewBuilder
    func searchableNavigationView() -> some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    ZentryIcon(DesignSystemAsset.Icons.chevronLeft)
                        .padding(9)
                        .foregroundColor(.zentry(.grayScale(.gray12)))
                    SearchableTextField(
                        viewStore.$query,
                        prompt: "분리수거 방법이 궁금한 쓰레기를 검색해보세요.",
                        focused: $focusedField
                    )
                    .bind(
                        viewStore.binding(
                            get: \.focusedField,
                            send: SearchStore.Action.binding(.set(\.$focusedField, focusedField))
                        ),
                        to: self.$focusedField
                    )
                    .onSubmit {
                        viewStore.send(.search)
                    }
                }
            }
            .padding(.leading, 9)
            .padding(.trailing, 18)
        }
    }
}
