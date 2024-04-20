#if DEBUG
// swiftlint:disable line_length
public extension SpaceClient {
  static var previewValue: Self {
    .init(
      fetchAllRockets: {
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
    )
  }
}
#endif
