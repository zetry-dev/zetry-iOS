//
//  CategoryCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/01.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Kingfisher
import SwiftUI

public struct CategoryCell: View {
    private let title: String
    private let imageUrl: String

    public init(_ title: String, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
    }

    public var body: some View {
        VStack {
            KFImage(imageUrl)
                .setFrame(width: 62, height: 62)
                .cornerRadius(20)
            Text(title)
                .fontStyle(.body2)
        }
    }
}

extension KFImage {
    init(_ urlString: String?) {
        self.init(source: URL(string: urlString ?? "")?.convertToSource())
    }

    func setFrame(width: CGFloat, height: CGFloat) -> some View {
        self
            .placeholder {
                Color.zetry(.grayScale(.gray3))
            }
            .fade(duration: 0.2)
            .cancelOnDisappear(true)
            .frame(width: width, height: height)
    }
}
