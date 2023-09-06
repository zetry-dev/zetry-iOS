//
//  UserDefaultsManager.swift
//  CoreKit
//
//  Created by AllieKim on 2023/08/24.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    public let key: String
    public let defaultValue: T
    public let storage: UserDefaults

    public var wrappedValue: T {
        get { self.storage.object(forKey: self.key) as? T ?? self.defaultValue }
        set { self.storage.set(newValue, forKey: self.key) }
    }

    public init(
        key: String,
        defaultValue: T,
        storage: UserDefaults = .init(suiteName: "com.userdefaults.zetry") ?? .standard
    ) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
}

public enum UserDefaultsManager {
    @UserDefault(key: "recent_keywords", defaultValue: [])
    public static var recentKeywords: [String]

    @UserDefault(key: "recommend_keywords", defaultValue: [])
    public static var recommendedKeywords: [String]
    
    @UserDefault(key: "top_keywords", defaultValue: [])
    public static var topKeywords: [String]

    @UserDefault(key: "keywords_date", defaultValue: .now)
    public static var keywordsDate: Date
}
