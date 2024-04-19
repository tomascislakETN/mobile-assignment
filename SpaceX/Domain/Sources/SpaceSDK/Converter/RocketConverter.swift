enum RocketConverter {
  static func convertToDomainModel(from external: [RocketDTO]) -> [Rocket] {
    external
      .map {
        .init(
          rocketName: $0.rocketName,
          description: $0.description,
          heightInMeters: $0.height.meters,
          diameterInMeters: $0.diameter.meters,
          massInKilograms: $0.mass.kg,
          firstFlight: $0.firstFlight,
          stages: StagesConverter.convertToDomainModel(from: $0)
        )
      }
  }
}
