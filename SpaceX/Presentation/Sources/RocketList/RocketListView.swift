import ComposableArchitecture
import SwiftUI
import UIToolkit

// MARK: - ViewState

extension RocketListFeature.State {
}

// MARK: - View

extension RocketListFeature {
  @ViewAction(for: RocketListFeature.self)
  public struct MainView: View {

    // MARK: - Properties

    @Bindable public var store: StoreOf<RocketListFeature>

    // MARK: - Body

    public var body: some View {
      NavigationView {
        List {
          ForEach(store.scope(state: \.cells, action: \.cells)) {
            RocketListFeature.RocketListCellFeature.MainView(store: $0)
          }
        }
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
