import CoreMotion
import Dependencies

// MARK: - MotionClient

public struct MotionClient {
  public var startAccelerometerUpdates: () async -> AsyncThrowingStream<MotionPoint, Error>
}

// MARK: - Dependency

extension MotionClient: DependencyKey {}

public extension DependencyValues {
  var motionClient: MotionClient {
    get { self[MotionClient.self] }
    set { self[MotionClient.self] = newValue }
  }
}
