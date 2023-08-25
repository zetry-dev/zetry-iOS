//
//  ZetryAlert.swift
//  DesignSystem
//
//  Created by Allie Kim on 2023/08/25.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct ZetryAlert: View {
    private let title: String
    private let positiveButtonTitle: String
    private let negativeButtonTitle: String

    public var body: some View {
        ZStack {
            Color.zetry(.grayScale(.gray12)).opacity(0.57)
            VStack {
                Text("전체 검색어를 삭제하시겠습니까?")
                HStack {
                    Button("") {}
                    Button("") {}
                }
            }
        }
    }
}
