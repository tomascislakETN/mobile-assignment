import Dependencies
import Foundation

// MARK: - NetworkingClient

public struct NetworkingClient {
  var request: (URL) async throws -> Data
}

// MARK: - Dependency

extension NetworkingClient: DependencyKey {}

public extension DependencyValues {
  var networkingClient: NetworkingClient {
    get { self[NetworkingClient.self] }
    set { self[NetworkingClient.self] = newValue }
  }
}
