import ComposableArchitecture
import RocketSDK

@Reducer
public struct RocketDetailFeature {

  public init() {}

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    var rocket: Rocket
    var stageFeatures: IdentifiedArrayOf<RocketDetailFeature.StageFeature.State>
    @Presents var destination: Destination.State?

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
    case destination(PresentationAction<Destination.Action>)

    public enum ViewAction {
      case launchButtonTapped
    }
  }

  // MARK: - Reducer

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .view(viewAction):
        switch viewAction {
        case .launchButtonTapped:
          state.destination = .launch(.init())

          return .none
        }

      case .stageFeatures, .destination:
        return .none
      }
    }
    .forEach(\.stageFeatures, action: \.stageFeatures, element: StageFeature.init)
    .ifLet(\.$destination, action: \.destination)
  }

  // MARK: - Navigation

  @Reducer(state: .equatable)
  public enum Destination {
    case launch(LaunchFeature)
  }
}
