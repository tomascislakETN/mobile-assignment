import CoreToolkit
import Dependencies
import Foundation
import Motion
import Networking

public extension RocketClient {
  static var liveValue: Self {
    @Dependency(\.motionClient) var motionClient
    @Dependency(\.networkingClient) var networkingClient

    return .init(
      fetchAllRockets: {
        let url = try RocketAPI.rockets.get()

        return RocketConverter.convertToDomainModel(
          from: try await networkingClient.performRequest(from: url)
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
