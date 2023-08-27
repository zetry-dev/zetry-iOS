import ComposableArchitecture
import FirebaseFirestore

public final class FireStoreService {
    public static let shared: FireStoreService = .init()

    init() {}

    public func test() async throws -> String {
        let firestore = Firestore.firestore()
        let ref = firestore.collection("products").document("keywords")
        let testResult = try await ref.getDocument()
        print(testResult.data())
        return "test!"
    }
}
