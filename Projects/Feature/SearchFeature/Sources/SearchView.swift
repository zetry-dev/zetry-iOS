//
//  SearchView.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zetry. All rights reserved.
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
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                searchableNavigationView(viewStore)
                ScrollView {
                    if viewStore.state.query.isEmpty {
                        recentSearchView(viewStore)
                        recommendSearchView(viewStore)
                        topKeywordsView(viewStore)
                    } else {
                        relatedKeywordView(viewStore)
                            .padding(.leading, 15)
                            .padding(.trailing, 20)
                    }
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

extension SearchView {
    @MainActor
    @ViewBuilder
    private func searchableNavigationView(_ viewStore: ViewStoreOf<SearchStore>) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 2) {
                ZetryIcon(DesignSystemAsset.Icons.chevronLeft)
                    .padding(9)
                    .foregroundColor(.zetry(.grayScale(.gray12)))
                    .onTapGesture {
                        viewStore.send(.pop)
                    }
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
                .onChange(of: viewStore.query, perform: {
                    if $0.isEmpty {
                        viewStore.send(.removeRelatedKeywords)
                    }
                })
                .onSubmit {
                    viewStore.send(.search)
                }
            }
        }
        .padding(.leading, 9)
        .padding(.trailing, 18)
    }

    @ViewBuilder
    private func recentSearchView(_ viewStore: ViewStoreOf<SearchStore>) -> some View {
        if !viewStore.recentKeywords.isEmpty {
            HStack {
                Text("최근 검색어")
                    .fontStyle(.subtitle3)
                Spacer()
                Button {
                    viewStore.send(.removeAllQueries)
                } label: {
                    Text("전체삭제")
                        .fontStyle(.label2, foregroundColor: .grayScale(.gray7))
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 18)

            scrollableQueryView(viewStore, canDelete: true)
        }
    }

    @ViewBuilder
    private func recommendSearchView(_ viewStore: ViewStoreOf<SearchStore>) -> some View {
        HStack {
            Text("추천 검색어")
                .fontStyle(.subtitle3)
            Spacer()
        }
        .padding(.top, 18)
        .padding(.horizontal, 18)

        scrollableQueryView(viewStore, canDelete: false)
    }

    @ViewBuilder
    private func topKeywordsView(_ viewStore: ViewStoreOf<SearchStore>) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("이웃들이 많이 찾아봤어요")
                    .fontStyle(.subtitle3)
                Spacer()
                Text(viewStore.state.updatedTimeStamp)
                    .fontStyle(.label4, foregroundColor: .grayScale(.gray7))
            }

            let topKeywords = viewStore.state.topKeywords
            HStack {
                VStack(alignment: .leading) {
                    ForEach(0 ... 4, id: \.self) { index in
                        if 0 ... 2 ~= index {
                            topKeywordView(topKeywords[index], index: index)
                                .onTapGesture {
                                    viewStore.send(.didTapQuery(topKeywords[index]))
                                }
                        } else {
                            keywordView(topKeywords[index], index: index)
                                .onTapGesture {
                                    viewStore.send(.didTapQuery(topKeywords[index]))
                                }
                        }
                    }
                }

                VStack(alignment: .leading) {
                    ForEach(5 ... 9, id: \.self) { index in
                        keywordView(topKeywords[index], index: index)
                            .onTapGesture {
                                viewStore.send(.didTapQuery(topKeywords[index]))
                            }
                    }
                }
            }
            .padding(.top, 16)
        }
        .padding(.top, 18)
        .padding(.horizontal, 18)
    }

    @ViewBuilder
    private func topKeywordView(_ keyword: String, index: Int) -> some View {
        HStack(spacing: 14) {
            Text("\(index + 1)")
                .fontStyle(.body1, foregroundColor: .primary(.primary))
            Text(keyword)
                .fontStyle(.body2)
            Spacer()
        }
        .contentShape(Rectangle())
        .padding(.vertical, 10)
    }

    @ViewBuilder
    private func keywordView(_ keyword: String, index: Int) -> some View {
        HStack(spacing: 14) {
            Text("\(index + 1)")
                .fontStyle(.body1)
            Text(keyword)
                .fontStyle(.body2)
            Spacer()
        }
        .contentShape(Rectangle())
        .padding(.vertical, 10)
    }

    @ViewBuilder
    private func scrollableQueryView(_ viewStore: ViewStoreOf<SearchStore>, canDelete: Bool) -> some View {
        let keywords = canDelete ? viewStore.recentKeywords : viewStore.recommendedKeywords

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 7) {
                ForEach(keywords.indices, id: \.self) { index in
                    Button {
                        viewStore.send(.didTapQuery(keywords[index]))
                    } label: {
                        HStack(spacing: 0) {
                            Text(keywords[index])
                            if canDelete {
                                ZetryIcon(DesignSystemAsset.Icons.xmark, foregroundColor: .grayScale(.gray6))
                                    .onTapGesture {
                                        viewStore.send(.removeQuery(index))
                                    }
                            }
                        }
                        .padding(.vertical, 6)
                        .padding(.leading, 12)
                        .padding(.trailing, canDelete ? 5 : 12)
                    }
                    .buttonStyle(.capsule)
                    .padding(.leading, index == 0 ? 16 : 0)
                }
            }
            .padding(.vertical, 8)
        }
    }

    @ViewBuilder
    private func relatedKeywordView(_ viewStore: ViewStoreOf<SearchStore>) -> some View {
        ForEach(viewStore.state.relatedKeywords, id: \.self) { keyword in
            HStack(spacing: 9) {
                ZetryIcon(DesignSystemAsset.Icons.magnifyingglassSizeSmaller, foregroundColor: .grayScale(.gray6))
                Text(keyword)
                    .fontStyle(.body2, foregroundColor: .grayScale(.gray9))
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewStore.send(.didTapQuery(keyword))
            }
            .padding(.top, 14)
        }
    }
}
