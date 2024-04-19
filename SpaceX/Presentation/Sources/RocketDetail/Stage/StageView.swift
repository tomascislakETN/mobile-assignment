import ComposableArchitecture
import SpaceSDK
import SwiftUI
import UIToolkit

// MARK: - ViewState

extension RocketDetailFeature.StageFeature.State {
  var title: String {
    switch stage.type {
    case .first:
      "First Stage"
    case .second:
      "Second Stage"
    }
  }

  var items: [(icon: Image, title: String)] {
    [
      (.reusable, stage.isReusable ? "reusable" : "not reusable"),
      (.engine, "\(stage.numberOfEngines) engines"),
      (.fuel, "\(Measurement(value: stage.fuelAmountInTons, unit: UnitMass.shortTons).formatted(.measurement(width: .wide))) of fuel"),
      stage.burnTimeInSec
        .map {
          (Image.burn, "\(Measurement(value: Double($0), unit: UnitDuration.seconds).formatted(.measurement(width: .wide))) burn time")
        }
    ]
      .compactMap { $0 }
  }
}

// MARK: - View

extension RocketDetailFeature.StageFeature {
  @ViewAction(for: RocketDetailFeature.StageFeature.self)
  struct MainView: View {

    // MARK: - Properties

    @Bindable var store: StoreOf<RocketDetailFeature.StageFeature>

    // MARK: - Body

    public var body: some View {
      Card {
        Section(title: store.title) {
          VStack(alignment: .leading) {
            ForEach(Array(store.items.enumerated()), id: \.offset) { _, item in
              HStack(spacing: .xxSmall) {
                item.icon

                Text(item.title)
              }
            }
          }
        }
      }
    }
  }
}

struct Card<Content: View>: View {
  let content: () -> Content
  var body: some View {
    content()
      .padding(.xSmall)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(.gray.opacity(0.15))
      .cornerRadius(16)
  }
}

// MARK: - Preview

#if DEBUG
#Preview {
  RocketDetailFeature.StageFeature.MainView(
    store: .init(
      initialState: .init(stage: .mock),
      reducer: RocketDetailFeature.StageFeature.init
    )
  )
}

#Preview {
  NavigationStack {
    RocketDetailFeature.MainView(
      store: .init(
        initialState: .init(rocket: .mock),
        reducer: RocketDetailFeature.init
      )
    )
  }
}
#endif
