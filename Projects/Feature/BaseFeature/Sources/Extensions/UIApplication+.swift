//
//  UIApplication+.swift
//  BaseFeature
//
//  Created by AllieKim on 2023/10/06.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import UIKit

public extension UIApplication {
    var appVersion: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
