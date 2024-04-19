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
      case delegate(Delegate)

      public enum ViewAction {
        case tapped
      }

      public enum Delegate {
        case tapped
      }
    }

    // MARK: - Reducer

    public var body: some ReducerOf<Self> {
      Reduce { _, action in
        switch action {
        case let .view(viewAction):
          switch viewAction {
          case .tapped:
            return .send(.delegate(.tapped))
          }

        case .delegate:
          return .none
        }
      }
    }
  }
}
