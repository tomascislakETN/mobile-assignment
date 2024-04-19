import ComposableArchitecture
import SpaceSDK
import SwiftUI
import UIToolkit

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
#endif
