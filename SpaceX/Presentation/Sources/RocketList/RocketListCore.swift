import ComposableArchitecture

@Reducer
public struct RocketListFeature {

  // MARK: - State

  @ObservableState
  public struct State: Equatable {
    var cells: IdentifiedArrayOf<RocketListFeature.RocketListCellFeature.State> = [
      .init(),
      .init(),
      .init(),
      .init()
    ]
  }

  // MARK: - Action

  public enum Action: ViewAction {
    case view(ViewAction)
    case cells(IdentifiedActionOf<RocketListFeature.RocketListCellFeature>)

    public enum ViewAction {
    }
  }

  // MARK: - Reducer

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
    .forEach(\.cells, action: \.cells, element: RocketListFeature.RocketListCellFeature.init)
  }
}
