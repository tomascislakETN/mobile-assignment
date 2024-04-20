import Dependencies

// MARK: - SpaceClient

public struct SpaceClient {
  public var fetchAllRockets: @Sendable () async throws -> [Rocket]
  public var rocketState: @Sendable () async -> AsyncThrowingStream<RocketState, Error>
}

// MARK: - Dependency

extension SpaceClient: DependencyKey {}

public extension DependencyValues {
  var spaceClient: SpaceClient {
    get { self[SpaceClient.self] }
    set { self[SpaceClient.self] = newValue }
  }
}

public enum RocketState: Equatable {
  case ready
  case flying
}

import Motion

enum RocketStateConverter {
  static func domainModel(from external: MotionPoint) -> RocketState {
    abs(external.z) < 0.5
    ? .flying
    : .ready
  }
}
