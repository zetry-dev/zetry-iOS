//
//  SearchView.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct SearchView: View {
    public let store: StoreOf<SearchReducer>

    public init(store: StoreOf<SearchReducer>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in

        }
    }
}
