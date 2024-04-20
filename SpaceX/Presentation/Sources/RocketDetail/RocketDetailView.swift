import ComposableArchitecture
import SwiftUI
import UIToolkit

// MARK: - ViewState

extension RocketDetailFeature.State {
  var navigationTitle: String {
    rocket.rocketName
  }

  var description: String {
    rocket.description
  }

  var parameters: [Parameter] {
    [
      rocket.heightInMeters
        .map {
          Parameter(
            title: Localizable.Rocket.Detail.Parameter.Height.title,
            value: Measurement(value: $0, unit: UnitLength.meters)
              .formatted(.measurement(width: .narrow, usage: .asProvided))
          )
        },
      rocket.diameterInMeters
        .map {
          Parameter(
            title: Localizable.Rocket.Detail.Parameter.Diameter.title,
            value: Measurement(value: $0, unit: UnitLength.meters)
              .formatted(.measurement(width: .narrow, usage: .asProvided))
          )
        },
          Parameter(
            title: Localizable.Rocket.Detail.Parameter.Mass.title,
            value: Measurement(value: Double(rocket.massInKilograms), unit: UnitMass.kilograms)
              .formatted()
          )
    ]
      .compactMap { $0 }
  }

  struct Parameter: Hashable {
    let title: String
    let value: String
  }

  var photos: [URL] {
    rocket.photos.compactMap(URL.init(string:))
  }
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
      ScrollView {
        VStack(alignment: .leading, spacing: .xSmall) {
          Section(title: Localizable.Rocket.Detail.Section.Overview.title) {
            Text(store.description)
              .font(.body)
              .foregroundColor(.Text.primary)
          }

          Section(title: Localizable.Rocket.Detail.Section.Parameters.title) {
            HStack(spacing: .xSmall) {
              ForEach(store.parameters, id: \.self) { parameter in
                ZStack {
                  Rectangle()
                    .fill(Color.brand)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(16)

                  VStack(spacing: .xSmall) {
                    Text(parameter.value)
                      .font(.title.weight(.bold))
                      .foregroundColor(Color.Text.tertiary)

                    Text(parameter.title)
                      .font(.body)
                      .foregroundColor(Color.Text.tertiary)
                  }

                }
              }
            }
          }

          VStack(spacing: .xSmall) {
            ForEach(store.scope(state: \.stageFeatures, action: \.stageFeatures), content: RocketDetailFeature.StageFeature.MainView.init)
          }

          Section(title: Localizable.Rocket.Detail.Section.Photos.title) {
            ForEach(store.photos, id: \.self) { url in
              AsyncImage(
                url: url,
                content: { $0
                  .resizable()
                  .scaledToFit()
                  .cornerRadius(16)
                },
                placeholder: { EmptyView() }
              )
            }
          }
        }
        .padding(.horizontal, .xSmall)
      }
      .navigationBarItems(
        trailing: Button("Launch") {
          send(.launchButtonTapped)
        }
      )
      .navigationDestination(
        item: $store.scope(state: \.destination?.launch, action: \.destination.launch),
        destination: LaunchFeature.MainView.init
      )
      .navigationTitle(store.navigationTitle)
    }
  }
}

// MARK: - Preview

#if DEBUG
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
