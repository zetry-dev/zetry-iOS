//
//  SettingsClient.swift
//  SettingsDomain
//
//  Created by AllieKim on 2023/10/06.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture

public struct SettingsClient {
    public var fetchAppStoreVersion: @Sendable () async throws -> String

    public init(
        fetchAppStoreVersion: @Sendable @escaping () async throws -> String
    ) {
        self.fetchAppStoreVersion = fetchAppStoreVersion
    }
}

extension SettingsClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchAppStoreVersion: { "" }
    )

    public static let testValue = Self(
        fetchAppStoreVersion: unimplemented("\(Self.self).settings.fetchAppStoreVersion")
    )
}
