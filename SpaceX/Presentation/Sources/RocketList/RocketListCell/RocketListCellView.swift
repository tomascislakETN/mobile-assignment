import ComposableArchitecture
import SpaceSDK
import SwiftUI
import UIToolkit

// MARK: - ViewState

extension RocketListFeature.RocketListCellFeature.State {
  var title: String {
    rocket.rocketName
  }

  var description: String {
    Localizable.Rocket.List.Cell.description(
      rocket.firstFlight.formatted(.dateTime.day().month(.twoDigits).year())
    )
  }
}

// MARK: - View

extension RocketListFeature.RocketListCellFeature {
  @ViewAction(for: RocketListFeature.RocketListCellFeature.self)
  struct MainView: View {

    // MARK: - Properties

    @Bindable var store: StoreOf<RocketListFeature.RocketListCellFeature>

    // MARK: - Body

    public var body: some View {
      HStack(spacing: .xSmall) {
        Image.rocket

        VStack(alignment: .leading, spacing: .xxSmall) {
          Text(store.title)
            .font(.title3)
            .foregroundColor(.Text.primary)

          Text(store.description)
            .font(.subheadline)
            .foregroundColor(.Text.secondary)
        }
      }
    }
  }
}

// MARK: - Preview

#if DEBUG
#Preview {
  RocketListFeature.RocketListCellFeature.MainView(
    store: .init(
      initialState: .init(rocket: .mock),
      reducer: RocketListFeature.RocketListCellFeature.init
    )
  )
}
#endif
