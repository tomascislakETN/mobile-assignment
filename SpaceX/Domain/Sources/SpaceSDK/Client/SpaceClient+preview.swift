import CoreToolkit

#if DEBUG
// swiftlint:disable line_length
public extension SpaceClient {
  static var previewValue: Self {
    .init(
      fetchAllRockets: {
        try await Task.sleep(for: .seconds(3))

        return [
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
      },
      rocketState: {
        AsyncThrowingStream { continuation in
          continuation.yield(.ready)

          Task {
            do {
              try await Task.sleep(nanoseconds: 3_000_000_000)

              continuation.yield(.flying)
              continuation.finish()
            } catch {
              continuation.finish(throwing: error)
            }
          }
        }
      }
    )
  }
}
#endif
