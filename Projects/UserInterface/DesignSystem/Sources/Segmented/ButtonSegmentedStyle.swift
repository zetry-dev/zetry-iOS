//
//  ButtonSegmentedStyle.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension SegmentStyle {
    enum ButtonSegmentedStyle: SegmentStyleProtocol {
        case style
    }
}

public extension SegmentStyle.ButtonSegmentedStyle {
    var selectedFontSize: Font.ZetryFontSystem {
        .body3
    }

    var unselectedFontSize: Font.ZetryFontSystem {
        .body3
    }

    var selectedColor: Color.ZetryColorSystem {
        .grayScale(.gray12)
    }

    var unselectedColor: Color.ZetryColorSystem {
        .primary(.white)
    }

    var lineColor: Color.ZetryColorSystem {
        .grayScale(.gray2)
    }
}
