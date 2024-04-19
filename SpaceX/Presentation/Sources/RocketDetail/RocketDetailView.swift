import ComposableArchitecture
import SwiftUI

// MARK: - ViewState

extension RocketDetailFeature.State {
}

// MARK: - View

extension RocketDetailFeature {
  @ViewAction(for: RocketDetailFeature.self)
  public struct MainView: View {

    // MARK: - Properties

    @Bindable public var store: StoreOf<RocketDetailFeature>

    // MARK: - Initialization

    public init(store: StoreOf<RocketDetailFeature>) {
      self.store = store
    }

    // MARK: - Body

    public var body: some View {
        Text("Detail")
    }
  }
}

// MARK: - Preview

#if DEBUG
#Preview {
  RocketDetailFeature.MainView(
    store: .init(
      initialState: .init(),
      reducer: RocketDetailFeature.init
    )
  )
}
#endif
