#if DEBUG
import XCTestDynamicOverlay

public extension SpaceClient {
  static var testValue = Self(
    fetchAllRockets: unimplemented("\(Self.self).fetchAllRockets"), 
    rocketState: unimplemented("\(Self.self).rocketState")
  )
}
#endif
