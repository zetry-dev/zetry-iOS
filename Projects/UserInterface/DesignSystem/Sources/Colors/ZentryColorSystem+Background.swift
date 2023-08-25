//
//  ZetryColorSystem+Background.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension Color.ZetryColorSystem {
    enum Background: ZetryColorable {
        case background
    }
}

public extension Color.ZetryColorSystem.Background {
    var color: Color {
        switch self {
        default: return .white
        }
    }

    var uiColor: UIColor {
        switch self {
        default: return .white
        }
    }
}
