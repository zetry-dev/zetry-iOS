//
//  HomeView.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

public struct HomeView: View {
    public let store: StoreOf<HomeStore>

    public init(store: StoreOf<HomeStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack {
                Button("검색하기") {
                    viewStore.send(.routeToSearch)
                }
                Text("홈")
            }
        }
    }
}

//
// public struct HomeCoordinator: Reducer {
//    public struct State: Equatable, IndexedRouterState {
//        public static let initialState = State(
//            routes: [.root(.home(.init()), embedInNavigationView: true)]
//        )
//
//        public var routes: [Route<AppScreen.State>]
//    }
//
//    public enum Action: IndexedRouterAction {
//        case routeAction(Int, action: AppScreen.Action)
//        case updateRoutes([Route<AppScreen.State>])
//    }
//
//    public var body: some ReducerOf<Self> {
//        Reduce<State, Action> { state, action in
//            switch action {
////            case .routeAction(_, .home(.startTapped)):
////                state.routes.presentSheet(.numbersList(.init(numbers: Array(0 ..< 4))), embedInNavigationView: true)
////
////            case .routeAction(_, .numbersList(.numberSelected(let number))):
////                state.routes.push(.numberDetail(.init(number: number)))
////
////            case .routeAction(_, .numberDetail(.showDouble(let number))):
////                state.routes.presentSheet(.numberDetail(.init(number: number * 2)), embedInNavigationView: true)
////
////            case .routeAction(_, .numberDetail(.goBackTapped)):
////                state.routes.goBack()
////
////            case .routeAction(_, .numberDetail(.goBackToNumbersList)):
////                return .routeWithDelaysIfUnsupported(state.routes) {
////                    $0.goBackTo(/Screen.State.numbersList)
////                }
////
////            case .routeAction(_, .numberDetail(.goBackToRootTapped)):
////                return .routeWithDelaysIfUnsupported(state.routes) {
////                    $0.goBackToRoot()
////                }
//
//            default:
//                break
//            }
//            return .none
//        }.forEachRoute {
////            AppScreen()
//        }
//    }
// }
