import ComposableArchitecture
import RocketDetail
import SpaceSDK

@Reducer
public struct RocketListFeature {
  @Dependency(\.spaceClient) var spaceClient

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    var cells: IdentifiedArrayOf<RocketListFeature.RocketListCellFeature.State> = []
    @Presents var destination: Destination.State?
  }

  // MARK: - Action

  public enum Action: ViewAction {
    case receivedRockets([Rocket])
    case view(ViewAction)
    case cells(IdentifiedActionOf<RocketListFeature.RocketListCellFeature>)
    case destination(PresentationAction<Destination.Action>)

    public enum ViewAction {
      case onAppear
    }
  }

  // MARK: - Reducer

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .receivedRockets(rockets):
        state.cells = IdentifiedArrayOf(
          uniqueElements: rockets.map(RocketListFeature.RocketListCellFeature.State.init)
        )

        return .none

      case let .view(viewAction):
        switch viewAction {
        case .onAppear:
          return .run { send in
            await send(.receivedRockets(try await spaceClient.fetchAllRockets()))
          }
        }

      case .cells(.element(_, .delegate(.tapped))):
        state.destination = .rocketDetail(.init())

        return .none

      case .cells, .destination:
        return .none
      }
    }
    .forEach(\.cells, action: \.cells, element: RocketListFeature.RocketListCellFeature.init)
    .ifLet(\.$destination, action: \.destination)
  }

  // MARK: - Navigation

  @Reducer(state: .equatable)
  public enum Destination {
    case rocketDetail(RocketDetailFeature)
  }
}
