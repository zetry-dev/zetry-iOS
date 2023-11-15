//
//  WebviewStore.swift
//  WebViewFeature
//
//  Created by Allie Kim on 2023/11/16.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture

public struct WebviewStore: Reducer {
    public init() {}

    public struct State: Equatable {
        let urlString: String
        
        public init(urlString: String) {
            self.urlString = urlString
        }
    }

    public enum Action: Equatable {
        case pop
    }

    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
