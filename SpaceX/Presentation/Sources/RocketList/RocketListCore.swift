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
    var receiveRocketsError: DomainError?
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
      case errorOKTapped
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

      case let .receivedRockets(.failure(error)):
        state.receiveRocketsError = error

        state.destination = .errorFeature(.init())

        return .none

      case let .view(viewAction):
        switch viewAction {
        case .onAppear:
          return fetchRockets(&state)

        case .errorOKTapped:
          state.destination = nil

          return fetchRockets(&state)
        }

      case let .cells(.element(id, .delegate(.tapped))):
        guard
          let rocket = state.cells[id: id]?.rocket
        else {
          return .none
        }

        state.destination = .rocketDetail(.init(rocket: rocket))

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
    case errorFeature(ErrorFeature)
  }
}

private extension RocketListFeature {
  func fetchRockets(_ state: inout State) -> Effect<Action> {
    state.receiveRocketsError = nil

    return .run { send in
      await send(.receivedRockets(.init { try await fetchAllRockets() }))
    }
  }
}

@Reducer
public struct ErrorFeature {}
