import ComposableArchitecture
import Foundation
import SpaceSDK

public extension RocketDetailFeature {
  @Reducer
  struct LaunchFeature {
    @Dependency(\.spaceClient) var spaceClient

    // MARK: - State

    @ObservableState
    public struct State: Equatable {
      var rocketState: RocketState?
      var offset: CGFloat = 0
    }

    // MARK: - Action

    public enum Action: ViewAction {
      case updateOffset
      case receivedRocketState(RocketState)
      case view(ViewAction)

      public enum ViewAction {
        case onAppear
      }
    }

    // MARK: - Reducer

    enum Cancellable: Hashable {
      case rocketState
    }

    public var body: some ReducerOf<Self> {
      Reduce { state, action in
        switch action {
        case let .receivedRocketState(rocketState):
          state.rocketState = rocketState

          guard rocketState == .flying else {
            return .none
          }

          return .merge(
            .run { send in
              await send(.updateOffset, animation: .easeInOut(duration: 2))
            },
            .cancel(id: Cancellable.rocketState)
          )

        case .updateOffset:
          state.offset = -1_000

          return .none

        case let .view(viewAction):
          switch viewAction {
          case .onAppear:
            return .run { send in
              for try await data in await spaceClient.rocketState() {
                await send(.receivedRocketState(data))
              }
            }
            .cancellable(id: Cancellable.rocketState, cancelInFlight: true)
          }
        }
      }
      ._printChanges()
    }
  }
}
