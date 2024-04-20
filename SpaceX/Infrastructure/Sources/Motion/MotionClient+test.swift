#if DEBUG
import XCTestDynamicOverlay

public extension MotionClient {
  static var testValue = Self(
    startAccelerometerUpdates: unimplemented("\(Self.self).startAccelerometerUpdates")
  )
}
#endif
