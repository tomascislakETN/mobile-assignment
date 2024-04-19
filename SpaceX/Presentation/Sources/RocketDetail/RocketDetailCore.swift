import ComposableArchitecture
import SpaceSDK

@Reducer
public struct RocketDetailFeature {

  public init() {}

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    var rocket: Rocket

    public init(rocket: Rocket) {
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
      return .none
    }
  }
}
