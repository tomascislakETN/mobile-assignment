#if DEBUG
import XCTestDynamicOverlay

public extension RocketClient {
  static var testValue = Self(
    fetchAllRockets: unimplemented("\(Self.self).fetchAllRockets"),
    rocketState: unimplemented("\(Self.self).rocketState")
  )
}
#endif
