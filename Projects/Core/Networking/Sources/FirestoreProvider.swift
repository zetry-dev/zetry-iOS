//
//  FireStoreProvider.swift
//  Networking
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import FirebaseFirestore
import NetworkingInterface

public final class FirestoreProvider {
    public static let shared: FirestoreProvider = .init()
    private let database: Firestore

    private init() {
        self.database = Firestore.firestore()
    }

    public func fetch(_ target: TargetType) async throws -> [String: Any] {
        let ref = database.collection(target.endPoint.rawValue).document(target.document)
        return try await ref.getDocument().data() ?? [:]
    }
}
