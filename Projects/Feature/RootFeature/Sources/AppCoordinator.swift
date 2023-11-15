//
//  AppCoordinator.swift
//  RootFeature
//
//  Created by Allie Kim on 2023/08/20.
//  Copyright © 2023 com.zetry. All rights reserved.
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

            case .routeAction(_, action: .mainTab(.home(.routeAction(_, action: .home(.routeToSearch))))),
                 .routeAction(_, action: .mainTab(.category(.routeAction(_, action: .category(.routeToSearch))))):
                state.routes.push(.search(.init()))
                return .none

            case let .routeAction(_, action: .mainTab(.home(.routeAction(_, action: .home(.routeToCategory(categoryTitle)))))):
                state.routes = [
                    .root(
                        .mainTab(.init(selectedTab: .category, selectedCategory: categoryTitle)),
                        embedInNavigationView: true)
                ]
                return .none

            case let .routeAction(_, action: .mainTab(.category(.routeAction(_, action: .category(.routeToProductDetail(product)))))):
                state.routes.push(.detail(.init(item: product)))
                return .none

            case let .routeAction(_, action: .search(.routeToDetail(item))),
                 let .routeAction(_, action: .search(.view(.routeToDetail(item)))):
                state.routes.push(.detail(.init(item: item)))
                return .none

            case let .routeAction(_, action: .mainTab(.home(.routeAction(_, action: .home(.routeToLiving(livingTab)))))):
                state.routes = [
                    .root(.mainTab(.init(selectedTab: .living, selectedLiving: livingTab)),
                          embedInNavigationView: true)
                ]
                return .none

            case let .routeAction(_, action: .detail(.routeToDetail(item))):
                state.routes.push(.detail(.init(item: item)))
                return .none

            case .routeAction(_, action: .detail(.popToRoot)):
                state.routes = [.root(.mainTab(.init()), embedInNavigationView: true)]
                return .none

            case let .routeAction(_, action: .mainTab(.home(.routeAction(_, action: .home(.routeToWebview(urlString)))))),
                let .routeAction(_, action: .mainTab(.living(.routeAction(_, action: .living(.routeToWebview(urlString)))))):
                state.routes.push(.webview(.init(urlString: urlString)))
                return .none

            case .routeAction(_, action: .search(.view(.pop))),
                 .routeAction(_, action: .detail(.pop)),
                 .routeAction(_, action: .webview(.pop)):
                state.routes.pop()
                return .none

            default:
                return .none
            }
        }
        .forEachRoute {
            AppScreen()
        }
    }
}
