//
//  SettingsStore.swift
//  SettingsFeature
//
//  Created by AllieKim on 2023/08/31.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import SettingsDomain
import SwiftUI

struct SettingItem: Equatable {
    var title: String
    let url: URL?

    init(title: String, url: URL? = nil) {
        self.title = title
        self.url = url
    }
}

public struct SettingsStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var listItems: [SettingItem] = []
        var updateNeeded: Bool = false
        public init() {}
    }

    public enum Action: Equatable {
        case onLoad

        case updateIfNeeded(comparison: String)
        case appVersionLoaded(TaskResult<String>, comparison: String)
    }

    @Dependency(\.settingsClient) private var settingsClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onLoad:
                var items = makeDefaultItem()
                if let appVersion = UIApplication.shared.appVersion {
                    items.append(.init(title: "버전 정보 \(appVersion)"))
                    state.listItems = items
                    return .send(.updateIfNeeded(comparison: appVersion))
                }
                state.listItems = items

            case .updateIfNeeded(let comparison):
                return .run { send in
                    let result = await TaskResult {
                        try await settingsClient.fetchAppStoreVersion()
                    }
                    await send(.appVersionLoaded(result, comparison: comparison))
                }

            case .appVersionLoaded(.success(let appVersion), let comparison):
                state.updateNeeded = updateIfNeeded(appStore: appVersion, device: comparison)

            default:
                return .none
            }
            return .none
        }
    }

    private func updateIfNeeded(appStore: String, device: String) -> Bool {
        let result = device.compare(appStore, options: .numeric)

        switch result {
        case .orderedDescending, .orderedSame:
            return false
        default:
            return true
        }
    }

    private func makeDefaultItem() -> [SettingItem] {
        [
            SettingItem(title: "개인정보 처리 방침", url: URL(string: "https://www.google.com")),
            SettingItem(title: "서비스 이용 약관", url: URL(string: "https://www.google.com"))
        ]
    }
}
