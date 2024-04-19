import ComposableArchitecture
import SpaceSDK

@Reducer
public struct RocketDetailFeature {

  public init() {}

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    var rocket: Rocket
    var stageFeatures: IdentifiedArrayOf<RocketDetailFeature.StageFeature.State>

    public init(rocket: Rocket) {
      self.rocket = rocket

      stageFeatures = IdentifiedArrayOf(
        uniqueElements: rocket.stages.map(StageFeature.State.init)
      )
    }
  }

  // MARK: - Action

  public enum Action: ViewAction {
    case view(ViewAction)
    case stageFeatures(IdentifiedActionOf<RocketDetailFeature.StageFeature>)

    public enum ViewAction {
    }
  }

  // MARK: - Reducer

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
    .forEach(\.stageFeatures, action: \.stageFeatures, element: StageFeature.init)
  }
}
