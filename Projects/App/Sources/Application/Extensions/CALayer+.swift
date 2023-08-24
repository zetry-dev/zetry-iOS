//
//  CALayer+.swift
//  Zentry
//
//  Created by Allie Kim on 2023/08/24.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.3,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 12
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}
