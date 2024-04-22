@testable import RocketSDK
import XCTest
@testable import Motion

final class RocketStateConverterTests: XCTestCase {
  func test_sut_should_return_ready_state() {
    let sut = RocketStateConverter.domainModel(
      from: .init(x: 1, y: 1, z: 1)
    )

    XCTAssertEqual(sut, .ready)
  }

  func test_sut_should_return_flying_state() {
    let sut = RocketStateConverter.domainModel(
      from: .init(x: 1, y: 1, z: 0.4)
    )

    XCTAssertEqual(sut, .flying)
  }
}
