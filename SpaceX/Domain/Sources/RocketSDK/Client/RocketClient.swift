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
