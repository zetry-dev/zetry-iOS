//
//  TestClient.swift
//  CategoryDomain
//
//  Created by Allie Kim on 2023/08/27.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import Networking

public struct TestClient {
    public var fetchAll: @Sendable () async throws -> String
}

extension TestClient: DependencyKey {
    public static var liveValue = Self(
        fetchAll: {
            try await FireStoreService.shared.test()
        }
    )
}

public extension DependencyValues {
    var testClient: TestClient {
        get { self[TestClient.self] }
        set { self[TestClient.self] = newValue }
    }
}
