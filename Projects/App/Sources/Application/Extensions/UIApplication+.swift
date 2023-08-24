//
//  UIApplication+.swift
//  Zentry
//
//  Created by AllieKim on 2023/08/24.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import UIKit

extension UIApplication {
    private func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func addTapGestureRecognizer() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else {
            return
        }

        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing(_:)))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        window.addGestureRecognizer(tapGesture)
    }
}
