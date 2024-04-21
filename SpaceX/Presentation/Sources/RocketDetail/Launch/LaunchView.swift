import ComposableArchitecture
import SwiftUI
import UIToolkit

// MARK: - ViewState

extension RocketDetailFeature.LaunchFeature.State {
  var isRocketIdleHidden: Bool {
    rocketState == .flying
  }

  var isRocketFlyingHidden: Bool {
    rocketState != .flying
  }

  var description: String {
    switch rocketState {
    case .ready:
      Localizable.Launch.ready
    case .flying:
      Localizable.Launch.flying
    case .none:
      Localizable.Launch.No.data
    }
  }
}

// MARK: - View

extension RocketDetailFeature.LaunchFeature {
  @ViewAction(for: RocketDetailFeature.LaunchFeature.self)
  struct MainView: View {

    // MARK: - Properties

    @Bindable var store: StoreOf<RocketDetailFeature.LaunchFeature>

    // MARK: - Body

    public var body: some View {
      VStack {
        Spacer()

        VStack(spacing: .xSmall) {
          ZStack {
            Image.rocketIdle
              .isHidden(store.isRocketIdleHidden)

            Image.rocketFlying
              .offset(y: store.offset)
              .isHidden(store.isRocketFlyingHidden)
          }

          Text(store.description)
            .font(.body)
            .foregroundColor(.Text.primary)
        }
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
  RocketDetailFeature.LaunchFeature.MainView(
    store: .init(
      initialState: .init(),
      reducer: RocketDetailFeature.LaunchFeature.init
    )
  )
}
#endif
