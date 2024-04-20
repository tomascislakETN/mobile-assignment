import ComposableArchitecture
@testable import RocketList
import SpaceSDK
import XCTest

final class RocketListCellViewStateTests: XCTestCase {
  func test_title_should_have_right_value() {
    let state = sut(
      rocket: .mock(rocketName: "name")
    )

    XCTAssertEqual(state.title, "name")
  }

  func test_description_should_have_right_value() {
    let date = Date.now

    let state = sut(
      rocket: .mock(firstFlight: date)
    )

    XCTAssertEqual(state.description, "First flight: \(date.formatted(.dateTime.day().month(.twoDigits).year()))")
  }
}

private extension RocketListCellViewStateTests {
  func sut(
    rocket: Rocket = .mock
  ) -> RocketListFeature.RocketListCellFeature.State {
    withDependencies {
      $0.uuid = .constant(.init(0))
    } operation: {
      .init(rocket: rocket)
    }
  }
}
