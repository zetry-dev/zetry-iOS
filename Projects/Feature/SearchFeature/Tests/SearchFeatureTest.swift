import ComposableArchitecture
@testable import SearchFeature
import XCTest

@MainActor
final class SearchFeatureTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_onAppear() async {
        let store = TestStore(initialState: SearchStore.State()) {
            SearchStore()
        } withDependencies: {
            $0.categoryClient = .previewValue
        }

        await store.send(.onAppear)
        await store.receive(.recommendDataLoaded(.success(.mock))) { newState in
            newState.recommendedKeywords = ["종이컵", "우산", "선풍기", "유리컵", "뽁뽁이"]
        }
    }
}
