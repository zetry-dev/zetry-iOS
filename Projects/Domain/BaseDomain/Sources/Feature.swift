import FirebaseFirestore

public final class FireStoreService {
    init() {}

    public func test() async throws {
        let firestore = Firestore.firestore(database: "products")
        let ref = firestore.document("keywords/title")
        let test = try await ref.getDocument()
    }
}
