#if DEBUG
import XCTestDynamicOverlay

public extension NetworkingClient {
  static var testValue = Self(
    request: unimplemented("\(Self.self).performRequest")
  )
}
#endif
