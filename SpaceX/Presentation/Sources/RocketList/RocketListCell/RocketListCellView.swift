import ComposableArchitecture
import SwiftUI

// MARK: - ViewState

extension RocketListFeature.RocketListCellFeature.State {
}

// MARK: - View

extension RocketListFeature.RocketListCellFeature {
  @ViewAction(for: RocketListFeature.RocketListCellFeature.self)
  struct MainView: View {

    // MARK: - Properties

    @Bindable var store: StoreOf<RocketListFeature.RocketListCellFeature>

    // MARK: - Body

    public var body: some View {
      Image.rocket
    }
  }
}

// MARK: - Preview

#if DEBUG
#Preview {
  RocketListFeature.RocketListCellFeature.MainView(
    store: .init(
      initialState: .init(),
      reducer: RocketListFeature.RocketListCellFeature.init
    )
  )
}
#endif
