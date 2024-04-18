import ComposableArchitecture
import SpaceSDK

public extension RocketListFeature {
  @Reducer
  struct RocketListCellFeature {

    // MARK: - State

    @ObservableState
    public struct State: Equatable, Identifiable {
      public let id: String
      var rocket: Rocket
      
      init(rocket: Rocket) {
        @Dependency(\.uuid) var uuid
        self.id = uuid().uuidString

        self.rocket = rocket
      }
    }

    // MARK: - Action

    public enum Action: ViewAction {
      case view(ViewAction)

      public enum ViewAction {
      }
    }

    // MARK: - Reducer

    public var body: some ReducerOf<Self> {
      Reduce { state, action in
          .none
      }
    }
  }
}
