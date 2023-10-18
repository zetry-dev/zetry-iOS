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

    public func fetch(_ target: TargetType) async throws -> [[String: Any]] {
        var endPoint = target.endPoint.rawValue
        if let path = target.path {
            endPoint += path
        }
        let ref = database.collection(endPoint)
        if let targetQuery = target.query {
            let query = ref.whereField(targetQuery.first!.key, isEqualTo: targetQuery.first!.value)
            return try await query.getDocuments().documents.map { $0.data() }
        } else {
            return try await ref.getDocuments().documents.map { $0.data() }
        }
    }
}
