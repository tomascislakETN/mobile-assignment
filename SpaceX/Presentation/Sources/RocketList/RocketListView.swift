import ComposableArchitecture
import RocketDetail
import SwiftUI
import UIToolkit
import SpaceSDK

// MARK: - View

extension RocketListFeature {
  @ViewAction(for: RocketListFeature.self)
  public struct MainView: View {

    // MARK: - Properties

    @Bindable public var store: StoreOf<RocketListFeature>

    // MARK: - Body

    public var body: some View {
      NavigationStack {
        List {
          ForEach(
            store.scope(state: \.cells, action: \.cells),
            content: RocketListFeature.RocketListCellFeature.MainView.init
          )
        }
        .redacted(data: store.cells.elements)
        .navigationDestination(
          item: $store.scope(state: \.destination?.rocketDetail, action: \.destination.rocketDetail),
          destination: RocketDetailFeature.MainView.init
        )
        .navigationTitle(Localizable.Rocket.List.Navigation.title)
      }
      .onAppear {
        send(.onAppear)
      }
    }
  }
}

// MARK: - Preview

#if DEBUG
#Preview {
  RocketListFeature.MainView(
    store: .init(
      initialState: .init(),
      reducer: RocketListFeature.init
    )
  )
}
#endif

extension RocketListFeature {
  public static let rootMainView = RocketListFeature.MainView(
    store: .init(
      initialState: .init(),
      reducer: RocketListFeature.init
    )
  )
}
