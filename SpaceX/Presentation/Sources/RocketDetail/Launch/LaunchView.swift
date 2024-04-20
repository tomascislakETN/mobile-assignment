import ComposableArchitecture
import SwiftUI
import UIToolkit

// MARK: - ViewState

extension RocketDetailFeature.LaunchFeature.State {
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
        Image.rocket

        Text("x: \((store.motionPoint?.x).corrected)")
        Text("y: \((store.motionPoint?.y).corrected)")
        Text("z: \((store.motionPoint?.z).corrected)")
      }
        .onAppear {
          send(.onAppear)
        }
    }
  }
}

extension Double? {
  var corrected: String {
    (self ?? 0).formatted(.number.precision(.fractionLength(1)))
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
