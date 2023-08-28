//
//  TargetType.swift
//  NetworkingInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public protocol TargetType {
    var endPoint: EndPoint { get }
    var document: String { get }
}
