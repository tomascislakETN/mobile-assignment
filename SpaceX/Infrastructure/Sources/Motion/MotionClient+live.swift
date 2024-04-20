import CoreMotion

public extension MotionClient {
  static var liveValue: Self {
    let manager = CMMotionManager()

    return .init(
      startAccelerometerUpdates: {
        AsyncThrowingStream { continuation in
          manager.startGyroUpdates(to: .main) { data, error in
            if let data {
              continuation.yield(
                with: .success(
                  GyroData(
                    x: data.rotationRate.x,
                    y: data.rotationRate.y,
                    z: data.rotationRate.z
                  )
                )
              )
            } else if let error {
              continuation.finish(throwing: error)
            }

            continuation.finish()
          }
        }
      }
    )
  }
}
