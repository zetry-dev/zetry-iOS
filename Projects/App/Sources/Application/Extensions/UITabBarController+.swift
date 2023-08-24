//
//  UITabBarController+.swift
//  Zentry
//
//  Created by Allie Kim on 2023/08/24.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import DesignSystem
import SwiftUI

extension UITabBarController {
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBar.tintColor = Color.zentry(.primary(.primary))
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = Color.zentry(.grayScale(.gray6))
        tabBar.backgroundColor = .white

        configureTabBarCornerRadius()
        configureTabBarShadow()
    }

    private func configureTabBarCornerRadius() {
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func configureTabBarShadow() {
        tabBar.clearShadow()
        tabBar.layer.applyShadow(alpha: 0.12, y: 0)
    }
}

extension UITabBar {
    func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
