//
//  HomeRootStore.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SearchFeature

// public struct HomeRootStore: Reducer {
//    public init() {}
//
//    public struct State: Equatable {
////        var path = StackState<Path.State>()
//        public init() {}
//    }
//
//    public enum Action: Equatable {
////        case path(StackAction<Path.State, Path.Action>)
//    }
//
//    public var body: some ReducerOf<Self> {
//        Reduce { _, action in
//            // Core logic for root feature
//            switch action {
//            default: return .none
//            }
//        }
////        .forEach(\.path, action: /Action.path) {
////            Path()
////        }
//    }
// }
//
// public extension HomeRootStore {
//    struct Path: Reducer {
//        public enum State: Equatable {
//            case home(HomeReducer.State)
//            case search(SearchReducer.State)
//        }
//
//        public enum Action: Equatable {
//            case home(HomeReducer.Action)
//            case search(SearchReducer.Action)
//        }
//
//        public var body: some ReducerOf<Self> {
//            Scope(state: /State.home, action: /Action.home) {
//                HomeReducer()
//            }
//            Scope(state: /State.search, action: /Action.search) {
//                SearchReducer()
//            }
//        }
//    }
// }
