//
//  Banner.swift
//  CoreKitInterface
//
//  Created by Allie Kim on 2023/11/09.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public protocol Banner: Equatable, Hashable {
    var title: String { get }
    var imageURL: String { get }
}
