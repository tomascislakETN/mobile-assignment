import ComposableArchitecture
import SwiftUI
import UIToolkit

// MARK: - ViewState

extension RocketListFeature.State {
}

// MARK: - View

extension RocketListFeature {
  @ViewAction(for: RocketListFeature.self)
  struct MainView: View {

    // MARK: - Properties

    @Bindable var store: StoreOf<RocketListFeature>

    // MARK: - Body

    public var body: some View {
      NavigationView {
        Form {
          ForEach(store.scope(state: \.cells, action: \.cells)) {
            RocketListFeature.RocketListCellFeature.MainView(store: $0)
          }
        }
        .navigationTitle(Localizable.Rocket.List.Navigation.title)
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
