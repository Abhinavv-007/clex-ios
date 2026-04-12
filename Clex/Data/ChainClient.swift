import Foundation

// ═══════════════════════════════════════════════════
//  ChainClient
//  Thin stub for talking to the deployed Clex backend.
//  Full transfer + vault + chain logic to be ported
//  from mobile-frontend-new/app/.../data/ in follow-up.
//
//  Endpoints (from mobile-frontend-new/INTEGRATION.md):
//    • https://clex.in
//    • https://clex.in/vault/api
//    • https://clex.in/vault/secret
//    • wss://signal.clex.in
// ═══════════════════════════════════════════════════

enum ClexEndpoint {
    static let base   = URL(string: "https://clex.in")!
    static let vault  = URL(string: "https://clex.in/vault/api")!
    static let secret = URL(string: "https://clex.in/vault/secret")!
    static let signal = URL(string: "wss://signal.clex.in")!
}

struct ChainEntry: Decodable, Identifiable {
    let id: String
    let hash: String
    let route: String
    let durationMs: Int
    let status: String
}

enum ChainClientError: Error {
    case transport(Error)
    case decoding(Error)
    case server(status: Int)
    case invalidResponse
}

actor ChainClient {
    static let shared = ChainClient()
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Fetch recent ledger entries. Endpoint shape is a placeholder until
    /// backend contracts are wired up.
    func fetchRecentLedger(limit: Int = 20) async throws -> [ChainEntry] {
        var url = ClexEndpoint.base
        url.append(path: "chain/recent")
        url.append(queryItems: [URLQueryItem(name: "limit", value: String(limit))])

        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse else {
                throw ChainClientError.invalidResponse
            }
            guard (200..<300).contains(http.statusCode) else {
                throw ChainClientError.server(status: http.statusCode)
            }
            do {
                return try JSONDecoder().decode([ChainEntry].self, from: data)
            } catch {
                throw ChainClientError.decoding(error)
            }
        } catch let e as ChainClientError {
            throw e
        } catch {
            throw ChainClientError.transport(error)
        }
    }
}
