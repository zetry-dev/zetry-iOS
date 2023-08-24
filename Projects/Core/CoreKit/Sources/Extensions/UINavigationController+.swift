//
//  UINavigationController+.swift
//  CoreKit
//
//  Created by AllieKim on 2023/08/24.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}

public func popToRoot() {
    let window = UIApplication.shared.connectedScenes
        .filter { $0.activationState == .foregroundActive }
        .map { $0 as? UIWindowScene }
        .compactMap { $0 }
        .first?.windows
        .filter(\.isKeyWindow)
        .first

    let profile = window?.rootViewController?.children.first as? UINavigationController

    profile?.popToRootViewController(animated: true)
}
