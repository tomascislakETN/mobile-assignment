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
            title: "height",
            value: Measurement(value: $0, unit: UnitLength.meters)
              .formatted(.measurement(width: .narrow, usage: .asProvided))
          )
        },
      rocket.diameterInMeters
        .map {
          Parameter(
            title: "diameter",
            value: Measurement(value: $0, unit: UnitLength.meters)
              .formatted(.measurement(width: .narrow, usage: .asProvided))
          )
        },
          Parameter(
            title: "mass",
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
          Section(title: "Overview") {
            Text(store.description)
              .font(.body)
              .foregroundColor(.Text.primary)
          }

          Section(title: "Parameters") {
            HStack(spacing: .xSmall) {
              ForEach(store.parameters, id: \.self) { parameter in
                ZStack {
                  Rectangle()
                    .fill(Color.brand)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)

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
        }
        .padding(.horizontal, .xSmall)
      }
      .navigationTitle(store.navigationTitle)
    }

    private struct Section<Content: View>: View {
      let title: String
      let content: () -> Content

      var body: some View {
        VStack(alignment: .leading, spacing: .xxSmall) {
          Text(title)
            .font(.title3.weight(.bold))
            .foregroundColor(.Text.primary)

          content()
        }
      }
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
