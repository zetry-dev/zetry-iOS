//
//  Array+.swift
//  CoreKit
//
//  Created by AllieKim on 2023/08/24.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }

    subscript(safe range: Range<Index>) -> [Element]? {
        if range.endIndex > endIndex {
            return range.startIndex >= endIndex ? nil : Array(self[range.startIndex ..< endIndex])
        } else {
            return Array(self[range])
        }
    }

    mutating func prepend(_ newElement: some Any) {
        if let element = newElement as? Element {
            insert(element, at: 0)
        }
    }

    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
