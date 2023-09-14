//
//  CachedAsyncImage.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/04.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct CachedAsyncImage<Content>: View where Content: View {
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    public init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = .init(animation: .easeInOut),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    public var body: some View {
        if let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

private enum ImageCache {
    private static var cache: [URL?: Image] = [:]
    static subscript(url: URL?) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
