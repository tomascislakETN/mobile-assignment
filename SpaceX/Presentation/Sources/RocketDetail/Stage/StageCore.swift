import ComposableArchitecture
import SpaceSDK

public extension RocketDetailFeature {
  @Reducer
  struct StageFeature {

    // MARK: - State

    @ObservableState
    public struct State: Equatable, Identifiable {
      public let id: String
      var stage: Stage

      init(stage: Stage) {
        @Dependency(\.uuid) var uuid

        self.id = uuid().uuidString
        self.stage = stage

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
        return .none
      }
    }
  }
}
