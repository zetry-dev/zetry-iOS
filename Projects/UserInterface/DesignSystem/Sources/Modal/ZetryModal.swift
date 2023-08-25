//
//  ZetryModal.swift
//  DesignSystem
//
//  Created by Allie Kim on 2023/08/25.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct ZetryModal<Content: View>: View {
    @Binding var isPresented: Bool
    private let content: () -> Content
    private let primaryButtonTitle: String
    private let secondaryButtonTitle: String
    private let primaryCompletion: (() -> Void)?
    private let secondaryCompletion: (() -> Void)?

    public init(
        isPresented: Binding<Bool>,
        primaryButtonTitle: String = "네",
        secondaryButtonTitle: String = "아니오",
        content: @escaping () -> Content,
        primaryCompletion: (() -> Void)? = nil,
        secondaryCompletion: (() -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self.content = content
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.primaryCompletion = primaryCompletion
        self.secondaryCompletion = secondaryCompletion
    }

    public var body: some View {
        GeometryReader { _ in
            ZStack {
                if isPresented {
                    VStack {
                        Color.zetry(.grayScale(.gray12)).opacity(0.57)
                            .transition(.opacity)
                            .onTapGesture {
                                self.isPresented.toggle()
                            }
                        VStack {
                            content()
                                .padding(.horizontal, 20)
                            HStack {
                                Button(secondaryButtonTitle) {
                                    secondaryCompletion?()
                                }
                                .buttonStyle(.secondary)

                                Button(primaryButtonTitle) {
                                    primaryCompletion?()
                                }
                                .buttonStyle(.primary)
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

public extension View {
    func zetryModal(
        isPresented: Binding<Bool>,
        opacity: Double,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(
            ZetryModalModifier(
                content: {
                    ZetryModal(
                        isPresented: isPresented,
                        content: content
                    )
                }
            )
        )
    }
}

private struct ZetryModalModifier<SheetContent>: ViewModifier where SheetContent: View {
    var content: () -> ZetryModal<SheetContent>

    func body(content: Content) -> some View {
        ZStack {
            content
            self.content()
        }
    }
}
