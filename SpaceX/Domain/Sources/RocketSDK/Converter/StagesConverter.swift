enum StagesConverter {
  static func convertToDomainModel(from external: RocketDTO) -> [Stage] {
    [
      .init(
        type: .first,
        isReusable: external.firstStage.reusable,
        numberOfEngines: external.firstStage.engines,
        fuelAmountInTons: external.firstStage.fuelAmountTons,
        burnTimeInSec: external.firstStage.burnTimeSEC
      ),
      .init(
        type: .second,
        isReusable: external.secondStage.reusable,
        numberOfEngines: external.secondStage.engines,
        fuelAmountInTons: external.secondStage.fuelAmountTons,
        burnTimeInSec: external.secondStage.burnTimeSEC
      )
    ]
  }
}
