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
        WithViewStore(self.store, observe: \.view, send: SearchStore.Action.view) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                searchableNavigationView(viewStore)
                ScrollView {
                    if viewStore.isEmptyResult {
                        // TODO: - EmptyResult
                        VStack(spacing: 35) {
                            Text("\"\(viewStore.query)\"에 대한 검색 결과가 없습니다.\n다시 한번 확인해 주세요.")
                                .fontStyle(.body2)
                                .padding(.top, 35)
                            Divider(color: .gray1, height: 3)
                        }
                    } else {
                        if viewStore.query.isEmpty {
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
            .task {
                viewStore.send(.onAppear)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

extension SearchView {
    struct ViewState: Equatable {
        @BindingViewState var query: String
        @BindingViewState var focusedField: Bool
        let topKeywords: [String]
        var recentKeywords: [String]
        let updatedTimeStamp: String
        let recommendedKeywords: [String]
        var relatedKeywords: [String]
        var isEmptyResult: Bool
    }
}

extension BindingViewStore<SearchStore.State> {
    var view: SearchView.ViewState {
        SearchView.ViewState(
            query: self.$query,
            focusedField: self.$focusedField,
            topKeywords: self.topKeywords,
            recentKeywords: self.recentKeywords,
            updatedTimeStamp: self.updatedTimeStamp,
            recommendedKeywords: self.recommendedKeywords,
            relatedKeywords: self.relatedKeywords,
            isEmptyResult: self.isEmptyResult
        )
    }
}

extension SearchView {
    @MainActor
    @ViewBuilder
    private func searchableNavigationView(
        _ viewStore: ViewStore<SearchView.ViewState, SearchStore.Action.View>
    ) -> some View {
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
                        send: SearchStore.Action.View.binding(.set(\.$focusedField, focusedField))
                    ),
                    to: self.$focusedField
                )
                .onChange(of: viewStore.query, perform: {
                    if $0.isEmpty {
                        viewStore.send(.removeRelatedKeywords)
                    }
                })
                .onSubmit {
                    viewStore.send(.didTapSearch)
                }
            }
        }
        .padding(.leading, 9)
        .padding(.trailing, 18)
    }

    @ViewBuilder
    private func recentSearchView(_ viewStore: ViewStore<SearchView.ViewState, SearchStore.Action.View>) -> some View {
        if !viewStore.recentKeywords.isEmpty {
            HStack {
                Text("최근 검색어")
                    .fontStyle(.subtitle3)
                Spacer()
                Button {
                    viewStore.send(.didTapRemoveAllQueries)
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
    private func recommendSearchView(
        _ viewStore: ViewStore<SearchView.ViewState, SearchStore.Action.View>
    ) -> some View {
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
    private func topKeywordsView(_ viewStore: ViewStore<SearchView.ViewState, SearchStore.Action.View>) -> some View {
        let topKeywords = viewStore.topKeywords
        if topKeywords.count > 9 {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("이웃들이 많이 찾아봤어요")
                        .fontStyle(.subtitle3)
                    Spacer()
                    Text(viewStore.updatedTimeStamp)
                        .fontStyle(.label4, foregroundColor: .grayScale(.gray7))
                }

                HStack(alignment: .lastTextBaseline) {
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
                    .padding(.top, 16)
                }
            }
            .padding(.top, 18)
            .padding(.horizontal, 18)
        }
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
    private func scrollableQueryView(
        _ viewStore: ViewStore<SearchView.ViewState, SearchStore.Action.View>,
        canDelete: Bool
    ) -> some View {
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
                                        viewStore.send(.didTapRemoveQuery(index))
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
    private func relatedKeywordView(
        _ viewStore: ViewStore<SearchView.ViewState, SearchStore.Action.View>
    ) -> some View {
        ForEach(viewStore.relatedKeywords, id: \.self) { keyword in
            HStack(spacing: 9) {
                ZetryIcon(DesignSystemAsset.Icons.magnifyingglass, foregroundColor: .grayScale(.gray6))
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
