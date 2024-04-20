import Foundation

public struct Stage: Equatable {
  public let type: `Type`
  public let isReusable: Bool
  public let numberOfEngines: Int
  public let fuelAmountInTons: Double
  public let burnTimeInSec: Int?

  public enum `Type` {
    case first
    case second
  }
}

#if DEBUG
public extension Stage {
  static func mock(
    type: Stage.`Type` = .first,
    isReusable: Bool = false,
    numberOfEngines: Int = 0,
    fuelAmountInTons: Double = 0,
    burnTimeInSec: Int? = nil
  ) -> Self {
    .init(
      type: type,
      isReusable: isReusable,
      numberOfEngines: numberOfEngines,
      fuelAmountInTons: fuelAmountInTons,
      burnTimeInSec: burnTimeInSec
    )
  }

  static var mock: Self {
    .mock()
  }
}

#endif
