import SwiftUI
import UIToolkit

extension RocketDetailFeature.StageFeature.State {
  var title: String {
    switch stage.type {
    case .first:
      Localizable.Rocket.Detail.Section.First.Stage.title
    case .second:
      Localizable.Rocket.Detail.Section.Second.Stage.title
    }
  }

  var items: [StageDescription] {
    [
      .init(
        icon: Image.reusable,
        title: stage.isReusable
        ? Localizable.Rocket.Detail.Stage.reusable
        : Localizable.Rocket.Detail.Stage.Not.reusable
      ),
      .init(
        icon: Image.engine,
        title: Localizable.Rocket.Detail.Stage.engine(stage.numberOfEngines)
      ),
      .init(
        icon: Image.fuel,
        title: Localizable.Rocket.Detail.Stage.fuel(
          Measurement(
            value: stage.fuelAmountInTons,
            unit: UnitMass.shortTons
          )
          .formatted(.measurement(width: .wide))
        )

      ),
      stage.burnTimeInSec
        .map {
          StageDescription(
            icon: Image.burn,
            title: Localizable.Rocket.Detail.Stage.burn(
              Measurement(
                value: Double($0),
                unit: UnitDuration.seconds
              )
              .formatted(.measurement(width: .wide))
            )
          )
        }
    ]
      .compactMap { $0 }
  }

  struct StageDescription {
    let icon: Image
    let title: String
  }
}
