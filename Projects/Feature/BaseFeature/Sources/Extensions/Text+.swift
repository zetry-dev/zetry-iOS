//
//  Text+.swift
//  BaseFeature
//
//  Created by Allie Kim on 2023/11/09.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension Text {
    init(_ string: String, configure: (inout AttributedString) -> Void) {
        var attributedString = AttributedString(string)
        configure(&attributedString)
        self.init(attributedString)
    }
}
