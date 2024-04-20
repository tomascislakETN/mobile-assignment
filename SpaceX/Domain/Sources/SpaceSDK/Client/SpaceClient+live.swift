import Dependencies
import Foundation
import Motion

public extension SpaceClient {
  static var liveValue: Self {
    @Dependency(\.motionClient) var motionClient

    @Sendable func performRequest<RequestedObject: Decodable>(from url: URL) async throws -> RequestedObject {
      let data = try await URLSession.shared.data(from: url)
      return try JSONDecoder.decoder.decode(RequestedObject.self, from: data.0)
    }

    return .init(
      fetchAllRockets: {
        RocketConverter.convertToDomainModel(
          from: try await performRequest(from: SpaceAPI.rockets!)
        )
      },
      rocketState: {
        await motionClient.startAccelerometerUpdates()
          .map(RocketStateConverter.domainModel)
          .eraseToThrowingStream()
      }
    )
  }
}
