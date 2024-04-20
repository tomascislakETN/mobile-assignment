import CoreMotion
import Dependencies

// MARK: - MotionClient

public struct MotionClient {
  var startAccelerometerUpdates: () async -> AsyncThrowingStream<GyroData, Error>
}

// MARK: - Dependency

extension MotionClient: DependencyKey {}

public extension DependencyValues {
  var motionClient: MotionClient {
    get { self[MotionClient.self] }
    set { self[MotionClient.self] = newValue }
  }
}

public struct GyroData: Equatable {
  public let x: Double
  public let y: Double
  public let z: Double
}
