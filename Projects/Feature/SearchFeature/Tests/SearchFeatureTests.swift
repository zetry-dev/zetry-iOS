//
//  SearchFeatureTest.swift
//  SearchFeatureTests
//
//  Created by AllieKim on 2023/08/29.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import CoreKit
import ProductDomain
@testable import SearchFeature
import XCTest

@MainActor
final class SearchFeatureTests: XCTestCase {
    var sut: TestStoreOf<SearchStore>!
    var continuousClock: TestClock = .init()

    override func setUpWithError() throws {
        try super.setUpWithError()
        setUpDefaultStore()
    }

    func setUpDefaultStore() {
        sut = TestStore(initialState: SearchStore.State()) {
            SearchStore()
        } withDependencies: {
            $0.productClient = .previewValue
            $0.continuousClock = continuousClock
        }
    }

    func setUpEmptyStore() {
        var state = SearchStore.State()
        state.query = ""
        state.items = .mock

        sut = TestStore(initialState: state) {
            SearchStore()
        } withDependencies: {
            $0.productClient = .previewValue
            $0.continuousClock = continuousClock
        }
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_onAppear_fetchRecommendedKeywords_success() async {
        await sut.send(.onAppear)

        await sut.receive(.itemDataLoaded(.success(.mock))) { newState in
            newState.items = .mock
        }

        XCTAssertEqual(sut.state.items, .mock)

        await sut.receive(.storeKeywords(.mock)) {
            SearchStore().storeRandomKeywordIfNeeded(&UserDefaultsManager.recommendedKeywords, data: .mock)
            SearchStore().storeRandomKeywordIfNeeded(&UserDefaultsManager.topKeywords, data: .mock)

            $0.recommendedKeywords = UserDefaultsManager.recommendedKeywords
            $0.topKeywords = UserDefaultsManager.topKeywords
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd 업데이트"

        await sut.receive(.updateTimeStamp) {
            $0.updatedTimeStamp = formatter.string(from: Date.now)
        }

        XCTAssertEqual(sut.state.updatedTimeStamp, formatter.string(from: Date.now))
    }

    func test_fetch_queryRelated_keywords() async {
        await sut.send(.binding(.set(\.$query, "종이"))) {
            $0.query = "종이"
        }
        XCTAssertEqual(sut.state.query, "종이")

        await continuousClock.advance(by: .seconds(1))
        await continuousClock.run()

        await sut.receive(.fetchSearchKeywords)
        await sut.receive(.relatedQueryDataLoaded(.success(.mock))) {
            $0.relatedKeywords = [ProductEntity].mock.map(\.title)
        }
        XCTAssertEqual(sut.state.relatedKeywords, ["종이컵", "박스", "신문지", "한지", "포장지"])
    }

    func test_search_containsQuery_success() async {
        await sut.send(.binding(.set(\.$query, "종이"))) {
            $0.query = "종이"
        }
        XCTAssertEqual(sut.state.query, "종이")
        await sut.send(.didTapSearch)
        await sut.receive(.routeToDetail(item: .mock))
        await sut.receive(.addRecentKeyword)
        await sut.receive(.removeRelatedKeywords) {
            $0.query = ""
            $0.relatedKeywords = []
        }
    }

    func test_search_containsQuery_failure() async {
        setUpEmptyStore()
        await sut.send(.didTapSearch)
        await sut.receive(.presentSearchFailure) {
            $0.isEmptyResult = true
        }
        await sut.receive(.addRecentKeyword)
        await sut.receive(.removeRelatedKeywords)
    }
}
