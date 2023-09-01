//
//  SearchFeatureTest.swift
//  SearchFeatureTests
//
//  Created by AllieKim on 2023/08/29.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import CategoryDomainInterface
@testable import SearchFeature
import XCTest

@MainActor
final class SearchFeatureTests: XCTestCase {
    var sut: TestStoreOf<SearchStore>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        initDefaultStore()
    }

    func initDefaultStore() {
        var state = SearchStore.State()
        state.query = "종이컵"
        state.subCategories = [.mock]

        sut = TestStore(initialState: state) {
            SearchStore()
        } withDependencies: {
            $0.categoryClient = .previewValue
        }
    }

    func initEmptyStore() {
        var state = SearchStore.State()
        state.query = ""
        state.subCategories = [.mock]

        sut = TestStore(initialState: state) {
            SearchStore()
        } withDependencies: {
            $0.categoryClient = .previewValue
        }
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_onAppear_fetchRecommendedKeywords_success() async {
        await sut.send(.onAppear)
        await sut.receive(.dataLoaded(.success(.mock))) { newState in
            newState.subCategories = CategoryEntity.mock.items
            newState.recommendedKeywords = CategoryEntity.mock.items.map(\.title)
        }
    }

    func test_search_containsQuery_success() async {
        await sut.send(.search)
        await sut.receive(.routeToDetail(query: sut.state.query))
        await sut.receive(.addRecentKeyword)
        await sut.receive(.removeRelatedKeywords)
    }

    func test_search_containsQuery_failure() async {
        initEmptyStore()
        await sut.send(.search)
        await sut.receive(.routeToSearchFailure)
        await sut.receive(.addRecentKeyword)
        await sut.receive(.removeRelatedKeywords)
    }
}
