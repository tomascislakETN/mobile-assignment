import ComposableArchitecture
import CoreToolkit
import RocketDetail
import RocketSDK

@Reducer
public struct RocketListFeature {
  @Dependency(\.rocketClient.fetchAllRockets) var fetchAllRockets

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    var cells: IdentifiedArrayOf<RocketListFeature.RocketListCellFeature.State> = []
    @Presents var destination: Destination.State?
  }

  // MARK: - Action

  public enum Action: ViewAction {
    case receivedRockets(Result<[Rocket], DomainError>)
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
      case let .receivedRockets(.success(rockets)):
        state.cells = IdentifiedArrayOf(
          uniqueElements: rockets.map(RocketListFeature.RocketListCellFeature.State.init)
        )

        return .none

      case let .view(viewAction):
        switch viewAction {
        case .onAppear:
          return .run { send in
            await send(.receivedRockets(.init { try await fetchAllRockets() }))
          }
        }

      case let .cells(.element(id, .delegate(.tapped))):
        guard
          let rocket = state.cells[id: id]?.rocket
        else {
          return .none
        }

        state.destination = .rocketDetail(.init(rocket: rocket))

        return .none

      case .cells, .destination, .receivedRockets:
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
