//
//  SegmentStyle.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

protocol SegmentStyleProtocol {
    var selectedFontSize: Font.ZetryFontSystem { get }
    var unselectedFontSize: Font.ZetryFontSystem { get }
    var selectedColor: Color.ZetryColorSystem { get }
    var unselectedColor: Color.ZetryColorSystem { get }
    var lineColor: Color.ZetryColorSystem { get }
}

public enum SegmentStyle {
    case line(LineSegmentedStyle)
    case button(ButtonSegmentedStyle)
}
