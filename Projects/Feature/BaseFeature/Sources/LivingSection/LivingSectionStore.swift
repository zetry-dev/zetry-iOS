//
//  LivingSectionStore.swift
//  BaseFeature
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import Foundation

// TEST
public struct LivingSectionItem: Equatable, Hashable {
    var listSection: [LivingItem]
    var bannerSection: LivingItem
    var scrollSection: [LivingItem]

    init() {
        listSection = Array(repeating: .init(), count: 2)
        bannerSection = .init()
        scrollSection = Array(repeating: .init(), count: 5)
    }
}

// TEST
public struct LivingItem: Equatable, Hashable {
    var title: String
    var subtitle: String
    var imageURL: String
    var destinationURL: String

    init() {
        title = "친환경 물품을 소개합니다."
        subtitle = "요즘 트렌드로 떠오르는 친환경 물품에 대해 간단하게 설명해드릴게요."
        imageURL = "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
        destinationURL = ""
    }

    public static func == (lhs: LivingItem, rhs: LivingItem) -> Bool {
        lhs.destinationURL == rhs.destinationURL
    }
}

public struct LivingSectionStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public var selectedLivingTab: LivingSegementedTab
        public var livingSectionItems: [Int: [LivingSectionItem]] = [LivingSegementedTab.home.rawValue: Array(repeating: .init(), count: 2)]

        public init(selectedLivingTab: LivingSegementedTab = .home) {
            self.selectedLivingTab = selectedLivingTab
        }
    }

    public enum Action: Equatable {
        case view(View)
        case test
    }

    public var body: some ReducerOf<Self> {
        BindingReducer(action: /Action.view)

        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }
}

public extension LivingSectionStore.Action {
    enum View: Equatable, BindableAction {
        case binding(BindingAction<LivingSectionStore.State>)
        case routeToLivingDetail(String)
    }
}
