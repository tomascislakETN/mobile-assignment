import Foundation

public struct Rocket: Equatable {
  public let rocketName: String
  public let description: String
  public let heightInMeters: Double?
  public let diameterInMeters: Double?
  public let massInKilograms: Int
  public let firstFlight: Date
  public let stages: [Stage]
  public let photos: [String]
}

#if DEBUG
// swiftlint:disable line_length
public extension Rocket {
  static func mock(
    rocketName: String = "",
    description: String = "",
    heightInMeters: Double? = 0,
    diameterInMeters: Double? = 0,
    massInKilograms: Int = 0,
    firstFlight: Date = .now,
    stages: [Stage] = [],
    photos: [String] = []
  ) -> Self {
    .init(
      rocketName: rocketName,
      description: description,
      heightInMeters: heightInMeters,
      diameterInMeters: diameterInMeters,
      massInKilograms: massInKilograms,
      firstFlight: firstFlight,
      stages: stages,
      photos: photos
    )
  }

  static var mock: Self = .mock(
    rocketName: "Rocket 9",
    description: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
    heightInMeters: 90,
    diameterInMeters: 40,
    massInKilograms: 500_000,
    stages: [
      .init(
        type: .first,
        isReusable: true,
        numberOfEngines: 1,
        fuelAmountInTons: 385,
        burnTimeInSec: 162
      ),
      .init(
        type: .second,
        isReusable: false,
        numberOfEngines: 9,
        fuelAmountInTons: 385,
        burnTimeInSec: 162
      )
    ],
    photos: ["https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg"]
  )
}
#endif

public extension Rocket {
  static var placeholder: [Self] {
    [
      .mock(
        rocketName: "Falcon 1",
        description: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
        firstFlight: .now
      ),
      .mock(
        rocketName: "Falcon 9",
        description: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
        firstFlight: .now
      ),
      .mock(
        rocketName: "Falcon Heavy",
        description: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
        firstFlight: .now
      ),
      .mock(
        rocketName: "Starship",
        description: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
        firstFlight: .now
      )
    ]
  }
}
