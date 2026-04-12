import Foundation

enum ClexEndpoint {
    static let base   = URL(string: "https://clex.in")!
    static let vault  = URL(string: "https://clex.in/vault/api")!
    static let secret = URL(string: "https://clex.in/vault/secret")!
    static let signal = URL(string: "wss://signal.clex.in")!
}

struct ChainStatsPayload: Decodable, Hashable {
    let totalSessions: Int
    let totalChains: Int
    let completedSessions: Int
}

struct ChainFileMeta: Decodable, Hashable {
    let category: String
    let type: String
    let size: Int64
    let hash: String?
}

struct ChainExplorerSession: Decodable, Identifiable, Hashable {
    let id: String
    let senderChainId: String
    let receiverChainId: String?
    let route: String
    let files: [ChainFileMeta]
    let status: String
    let startedAt: Int64
    let completedAt: Int64?
    let durationMs: Int64?
    let ledgerIndex: Int
    let recordHash: String
}

struct ChainSessionEvent: Decodable, Hashable, Identifiable {
    let id: Int
    let status: String
    let ts: Int64
}

struct ChainSessionDetail: Decodable, Identifiable, Hashable {
    let id: String
    let senderChainId: String
    let receiverChainId: String?
    let route: String
    let files: [ChainFileMeta]
    let status: String
    let startedAt: Int64
    let completedAt: Int64?
    let durationMs: Int64?
    let ledgerIndex: Int
    let previousHash: String?
    let recordHash: String
    let events: [ChainSessionEvent]
}

private struct ExplorerResponse: Decodable {
    let sessions: [ChainExplorerSession]
}

struct ChainFeed: Hashable {
    let stats: ChainStatsPayload
    let sessions: [ChainExplorerSession]
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
    private let decoder: JSONDecoder

    init(session: URLSession = .shared) {
        self.session = session
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = decoder
    }

    func fetchFeed(limit: Int = 20) async throws -> ChainFeed {
        var statsUrl = ClexEndpoint.base
        statsUrl.append(path: "chain/stats")

        var explorerUrl = ClexEndpoint.base
        explorerUrl.append(path: "chain/explorer")
        explorerUrl.append(queryItems: [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "limit", value: String(limit))
        ])

        let statsURL = statsUrl
        let explorerURL = explorerUrl
        async let stats: ChainStatsPayload = request(statsURL)
        async let explorer: ExplorerResponse = request(explorerURL)
        return try await ChainFeed(stats: stats, sessions: explorer.sessions)
    }

    func fetchSession(id: String) async throws -> ChainSessionDetail {
        var url = ClexEndpoint.base
        url.append(path: "chain/session/\(id)")
        return try await request(url)
    }

    private func request<T: Decodable>(_ url: URL) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse else {
                throw ChainClientError.invalidResponse
            }
            guard (200..<300).contains(http.statusCode) else {
                throw ChainClientError.server(status: http.statusCode)
            }
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw ChainClientError.decoding(error)
            }
        } catch let error as ChainClientError {
            throw error
        } catch {
            throw ChainClientError.transport(error)
        }
    }
}
