import Dependencies

// MARK: - RocketClient

public struct RocketClient {
  public var fetchAllRockets: @Sendable () async throws -> [Rocket]
  public var rocketState: @Sendable () async -> AsyncThrowingStream<RocketState, Error>
}

// MARK: - Dependency

extension RocketClient: DependencyKey {}

public extension DependencyValues {
  var rocketClient: RocketClient {
    get { self[RocketClient.self] }
    set { self[RocketClient.self] = newValue }
  }
}
