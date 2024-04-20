import CoreMotion

public extension MotionClient {
  static var liveValue: Self {
    let motionManager = CMMotionManager()

    return .init(
      startAccelerometerUpdates: {
        AsyncThrowingStream { continuation in
          motionManager.startAccelerometerUpdates(to: .init()) { data, error in

            if let data {
              continuation.yield(
                with: .success(
                  .init(
                    x: data.acceleration.x,
                    y: data.acceleration.y,
                    z: data.acceleration.z
                  )
                )
              )
            } else if let error {
              continuation.finish(throwing: error)
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
