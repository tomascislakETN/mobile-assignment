import ComposableArchitecture
@testable import RocketDetail
import SpaceSDK
import XCTest

final class RocketDetailCoreTests: XCTestCase {
  typealias Feature = RocketDetailFeature

  @MainActor
  func test_sut_should_get_data_on_appear() async {
    let store = TestStore(
      initialState: .sut(rocket: .mock(stages: [.mock()])),
      reducer: Feature.init
    )

    await store.send(.view(.launchButtonTapped)) {
      $0.destination = .launch(.init())
    }
  }
}

private extension RocketDetailFeature.State {
  static func sut(
    rocket: Rocket = .mock
  ) -> Self {
    withDependencies {
      $0.uuid = .constant(.init(0))
    } operation: {
      .init(rocket: rocket)
    }
  }
}
