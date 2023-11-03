//
//  String+.swift
//  CoreKit
//
//  Created by Allie Kim on 2023/11/03.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public extension String {
    func nonBreakingSpaced() -> String {
        return self.replacingOccurrences(of: " ", with: "\u{202F}")
    }
}
