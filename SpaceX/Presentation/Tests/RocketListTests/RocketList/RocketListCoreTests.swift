import ComposableArchitecture
@testable import RocketList
import SpaceSDK
import XCTest

final class RocketListTests: XCTestCase {
  typealias Feature = RocketListFeature

  @MainActor
  func test_sut_should_get_data_on_appear() async {
    let store = TestStore(
      initialState: Feature.State(),
      reducer: Feature.init
    ) {
      $0.spaceClient.fetchAllRockets = { [.mock] }
      $0.uuid = .constant(.init(0))
    }

    await store.send(.view(.onAppear))

    await store.receive(\.receivedRockets) {
      $0.cells = IdentifiedArrayOf(uniqueElements: [.init(rocket: .mock)])
    }
  }

  @MainActor
  func test_sut_should_show_detail_when_tapped_cell() async {
    let rocket = Rocket.mock(rocketName: "rocket")
    let store = TestStore(
      initialState: .state(rockets: [rocket]),
      reducer: Feature.init
    )

    await store.send(.cells(.element(id: "00000000-0000-0000-0000-000000000000", action: .delegate(.tapped)))) {
      $0.destination = .rocketDetail(.init(rocket: rocket))
    }
  }
}

private extension RocketListFeature.State {
  static func state(
    rockets: [Rocket] = [.mock]
  ) -> Self {
    withDependencies {
      $0.uuid = .constant(.init(0))
    } operation: {
      var state = RocketListFeature.State()
      state.cells = IdentifiedArrayOf(
        uniqueElements: rockets.map(RocketListFeature.RocketListCellFeature.State.init)
      )

      return state
    }
  }
}
