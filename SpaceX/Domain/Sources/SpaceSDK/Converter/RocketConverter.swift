enum RocketConverter {
  static func convertToDomainModel(from external: [RocketDTO]) -> [Rocket] {
    external
      .map {
        .init(
          rocketName: $0.rocketName,
          firstFlight: $0.firstFlight
        )
      }
  }
}
