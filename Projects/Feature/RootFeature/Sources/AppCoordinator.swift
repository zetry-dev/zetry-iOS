//
//  AppCoordinator.swift
//  RootFeature
//
//  Created by Allie Kim on 2023/08/20.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import LaunchScreenFeature
import TCACoordinators

public struct AppCoordinator: Reducer {
    public init() {}

    public struct State: Equatable, IndexedRouterState {
        public var routes: [Route<AppScreen.State>]

        public init(routes: [Route<AppScreen.State>] = [.root(.launch(.init()), embedInNavigationView: true)]) {
            self.routes = routes
        }
    }

    public enum Action: IndexedRouterAction {
        case updateRoutes([Route<AppScreen.State>])
        case routeAction(Int, action: AppScreen.Action)
    }

    enum CancelID { case onAppear }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .routeAction(_, action: .launch(.onAppear)):
                return .run { send in
                    await send(.routeAction(0, action: .launch(.onDisappear)))
                }
                .debounce(id: CancelID.onAppear, for: .seconds(2), scheduler: UIScheduler.shared)
            case .routeAction(_, action: .launch(.onDisappear)):
                state.routes = [.root(.mainTab(.init()), embedInNavigationView: true)]
                return .none
//            case let .routeAction(_, action: .mainTab(.tabSelected(tab))):
//                switch tab {
//                case .home:
//                    return .send(.routeAction(0, action: .mainTab(.home(.routeAction(0, action: .home(.onAppear))))))
//                case .category:
//                    return .send(.routeAction(0, action: .mainTab(.category(.routeAction(0, action: .category(.onAppear))))))
//                case .living:
//                    return .send(.routeAction(0, action: .mainTab(.living(.routeAction(0, action: .living(.onAppear))))))
//                }
//            case .routeAction(_, action: .mainTab(.home(.routeAction(_, action: .home(.onAppear))))):
//                return .none
//            case .routeAction(_, action: .mainTab(.category(.routeAction(_, action: .category(.onAppear))))):
//                return .none
//            case .routeAction(_, action: .mainTab(.living(.routeAction(_, action: .living(.onAppear))))):
//                return .none
            default:
                return .none
            }
        }
    }
}
