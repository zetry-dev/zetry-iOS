//
//  Array+.swift
//  CoreKit
//
//  Created by AllieKim on 2023/08/24.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public extension Array {
    mutating func prepend(_ newElement: some Any) {
        if let element = newElement as? Element {
            insert(element, at: 0)
        }
    }
}
