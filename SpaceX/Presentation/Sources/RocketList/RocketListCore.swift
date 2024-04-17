import ComposableArchitecture

@Reducer
public struct RocketListFeature {

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
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
