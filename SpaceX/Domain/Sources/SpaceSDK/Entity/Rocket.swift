import Foundation

public struct Rocket: Equatable {
  public let rocketName: String
  public let description: String
  public let heightInMeters: Double?
  public let diameterInMeters: Double?
  public let massInKilograms: Int
  public let firstFlight: Date

}

#if DEBUG
public extension Rocket {
  static func mock(
    rocketName: String = "",
    description: String = "",
    heightInMeters: Double? = 0,
    diameterInMeters: Double? = 0,
    massInKilograms: Int = 0,
    firstFlight: Date = .now
  ) -> Self {
    .init(
      rocketName: rocketName,
      description: description,
      heightInMeters: heightInMeters,
      diameterInMeters: diameterInMeters,
      massInKilograms: massInKilograms,
      firstFlight: firstFlight
    )
  }

  static var mock: Self = .mock(
    rocketName: "Rocket 9",
    description: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
    heightInMeters: 90,
    diameterInMeters: 40,
    massInKilograms: 500_000
  )
}
#endif
