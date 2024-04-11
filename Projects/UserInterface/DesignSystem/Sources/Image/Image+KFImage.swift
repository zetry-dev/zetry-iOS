//
//  CachedAsyncImage.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/04.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Kingfisher
import SwiftUI

public extension Image {
    @ViewBuilder
    static func load(
        _ url: String?,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        centerCropped: Bool = true
    ) -> some View {
        if centerCropped {
            KFImage(url)
                .addScale(width: width, height: height)
        }else {
            KFImage(url)
                .addScaleNotCropped(width: width, height: height)
        }
    }
}

public extension KFImage {
    init(_ urlString: String?) {
        self.init(source: URL(string: urlString ?? "")?.convertToSource())
    }

    @ViewBuilder
    func addScale(width: CGFloat?, height: CGFloat?) -> some View {
        self
            .cacheOriginalImage()
            .placeholder {
                Color
                    .zetry(.grayScale(.gray2))
            }
            .resizable()
            .fade(duration: 0.2)
            .cancelOnDisappear(true)
            .centerCropped()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
    }

    @ViewBuilder
    func addScaleNotCropped(width: CGFloat?, height: CGFloat?) -> some View {
        self
            .cacheOriginalImage()
            .placeholder {
                Color
                    .zetry(.grayScale(.gray2))
            }
            .resizable()
            .fade(duration: 0.2)
            .cancelOnDisappear(true)
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
    }

    @ViewBuilder
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}
