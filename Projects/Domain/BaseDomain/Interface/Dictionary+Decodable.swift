//
//  Dictionary+.swift
//  BaseDomain
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public extension [String: Any] {
    func mapping<T: Decodable>(_ objectType: T.Type) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self) else { return nil }
        guard let objects = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return objects
    }
}
