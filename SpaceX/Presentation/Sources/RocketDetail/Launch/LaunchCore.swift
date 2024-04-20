import ComposableArchitecture
import Motion

public extension RocketDetailFeature {
  @Reducer
  struct LaunchFeature {
    @Dependency(\.motionClient) var motionClient

    // MARK: - State

    @ObservableState
    public struct State: Equatable {
      var motionPoint: MotionPoint?
    }

    // MARK: - Action

    public enum Action: ViewAction {
      case receivedPoint(MotionPoint)
      case view(ViewAction)

      public enum ViewAction {
        case onAppear
      }
    }

    // MARK: - Reducer

    public var body: some ReducerOf<Self> {
      Reduce { state, action in
        switch action {
        case let .receivedPoint(motionPoint):
          state.motionPoint = motionPoint

          return .none

        case let .view(viewAction):
          switch viewAction {
          case .onAppear:
            return .run { send in
              for try await data in await motionClient.startAccelerometerUpdates() {
                await send(.receivedPoint(data))
              }
            }
          }
        }
      }
      ._printChanges()
    }
  }
}
