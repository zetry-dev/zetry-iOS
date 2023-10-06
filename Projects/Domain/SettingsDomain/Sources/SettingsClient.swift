//
//  SettingsClient.swift
//  SettingsDomainInterface
//
//  Created by AllieKim on 2023/10/06.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
import ComposableArchitecture
import CoreKit
import Foundation
import Networking
import SettingsDomainInterface

public extension DependencyValues {
    var settingsClient: SettingsClient {
        get { self[SettingsClient.self] }
        set { self[SettingsClient.self] = newValue }
    }
}

extension SettingsClient: DependencyKey {
    public static var liveValue = Self(
        fetchAppStoreVersion: {
            guard let url = URL(string: "https://itunes.apple.com/lookup?bundleId=com.zetry.Zetry") else { return "1.0" }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                let results = json["results"] as? [[String: Any]],
                let appStoreVersion = results[safe: 0]?["version"] as? String
            else {
                return "1.0"
            }
            return appStoreVersion
        }
    )
}
