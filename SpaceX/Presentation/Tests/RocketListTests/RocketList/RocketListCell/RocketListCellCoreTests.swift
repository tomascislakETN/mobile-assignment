import ComposableArchitecture
@testable import RocketList
import SpaceSDK
import XCTest

final class RocketListCellTests: XCTestCase {
  typealias Feature = RocketListFeature.RocketListCellFeature

  @MainActor
  func test_sut_should_get_data_on_appear() async {
    let store = TestStore(
      initialState: .state(),
      reducer: Feature.init
    )

    await store.send(.view(.tapped))

    await store.receive(\.delegate.tapped)
  }
}

private extension RocketListFeature.RocketListCellFeature.State {
  static func state(
    rocket: Rocket = .mock
  ) -> Self {
    withDependencies {
      $0.uuid = .constant(.init(0))
    } operation: {
      .init(rocket: rocket)
    }
  }
}
