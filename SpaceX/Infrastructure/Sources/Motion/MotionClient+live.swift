import CoreMotion
import CoreToolkit

public extension MotionClient {
  static var liveValue: Self {
    let motionManager = CMMotionManager()

    return .init(
      startAccelerometerUpdates: {
        .init { continuation in
          motionManager.startAccelerometerUpdates(to: .init()) { data, error in

            if let data {
              continuation.yield(
                .init(
                  x: data.acceleration.x,
                  y: data.acceleration.y,
                  z: data.acceleration.z
                )
              )
            } else if let error {
              continuation.finish(throwing: DomainError.createAndLog(cause: .motionError, underlyingError: error))
            }
          }

          continuation.onTermination = { @Sendable (termination) in
            motionManager.stopAccelerometerUpdates()
          }
        }
      }
    )
  }
}
