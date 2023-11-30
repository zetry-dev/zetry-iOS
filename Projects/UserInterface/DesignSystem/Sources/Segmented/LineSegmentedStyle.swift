//
//  LineSegmentedStyle.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension SegmentStyle {
    enum LineSegmentedStyle: SegmentStyleProtocol {
        case style
    }
}

public extension SegmentStyle.LineSegmentedStyle {
    var selectedFontSize: Font.ZetryFontSystem {
        .subtitle3
    }

    var unselectedFontSize: Font.ZetryFontSystem {
        .body2
    }

    var selectedColor: Color.ZetryColorSystem {
        .grayScale(.gray12)
    }

    var unselectedColor: Color.ZetryColorSystem {
        .grayScale(.gray6)
    }

    var lineColor: Color.ZetryColorSystem {
        .primary(.primary)
    }
}
