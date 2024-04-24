import ComposableArchitecture
@testable import RocketDetail
import RocketSDK
import XCTest

final class LaunchCoreTests: XCTestCase {
  typealias Feature = RocketDetailFeature.LaunchFeature

  @MainActor
  func test_sut_should_get_data_on_appear() async {
    let store = TestStore(
      initialState: Feature.State(),
      reducer: Feature.init
    ) {
      $0.rocketClient.rocketState = {
        .just(.ready)
      }
    }

    await store.send(.view(.onAppear))

    await store.receive(\.receivedRocketState) {
      $0.rocketState = .ready
    }
  }

  @MainActor
  func test_sut_should_move_rocket_when_receive_flying_state() async {
    let store = TestStore(
      initialState: Feature.State(),
      reducer: Feature.init
    ) {
      $0.rocketClient.rocketState = {
        .just(.flying)
      }
    }

    await store.send(.view(.onAppear))

    await store.receive(\.receivedRocketState) {
      $0.rocketState = .flying
    }

    await store.receive(\.updateOffset) {
      $0.isSpacerHidden = false
    }
  }
}
