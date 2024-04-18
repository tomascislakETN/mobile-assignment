import Dependencies

// MARK: - SpaceClient

public struct SpaceClient {
  public var fetchAllRockets: @Sendable () async throws -> [Rocket]
}

// MARK: - Dependency

extension SpaceClient: DependencyKey {}

public extension DependencyValues {
  var spaceClient: SpaceClient {
    get { self[SpaceClient.self] }
    set { self[SpaceClient.self] = newValue }
  }
}
