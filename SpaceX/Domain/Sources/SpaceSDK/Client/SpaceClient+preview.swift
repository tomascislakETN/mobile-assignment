#if DEBUG
public extension SpaceClient {
  static var previewValue: Self {
    .init(
      fetchAllRockets: {
        [
          .init(
            rocketName: "Falcon 1",
            firstFlight: .now
          ),
          .init(
            rocketName: "Falcon 9",
            firstFlight: .now
          ),
          .init(
            rocketName: "Falcon Heavy",
            firstFlight: .now
          ),
          .init(
            rocketName: "Starship",
            firstFlight: .now
          )
        ]
      }
    )
  }
}
#endif
