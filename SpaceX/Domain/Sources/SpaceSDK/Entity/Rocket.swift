import Foundation

public struct Rocket: Equatable {
  public let rocketName: String
  public let firstFlight: Date
}

#if DEBUG
public extension Rocket {
  static func mock(
    rocketName: String = "",
    firstFlight: Date = .now
  ) -> Self {
    .init(
      rocketName: rocketName,
      firstFlight: firstFlight
    )
  }

  static var mock: Self = .mock()
}
#endif
