import ComposableArchitecture
import SpaceSDK

@Reducer
public struct RocketListFeature {
  @Dependency(\.spaceClient) var spaceClient

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    var cells: IdentifiedArrayOf<RocketListFeature.RocketListCellFeature.State> = []
  }

  // MARK: - Action

  public enum Action: ViewAction {
    case receivedRockets([Rocket])
    case view(ViewAction)
    case cells(IdentifiedActionOf<RocketListFeature.RocketListCellFeature>)

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

      case .cells:
        return .none
      }
    }
    .forEach(\.cells, action: \.cells, element: RocketListFeature.RocketListCellFeature.init)
  }
}
