import CoreToolkit
import Dependencies
import Foundation
import Motion

public extension RocketClient {
  static var liveValue: Self {
    @Dependency(\.motionClient) var motionClient

    @Sendable func performRequest<RequestedObject: Decodable>(from url: URL) async throws -> RequestedObject {
      let data = try await URLSession.shared.data(from: url)
      guard let urlResponse = data.1 as? HTTPURLResponse else {
        throw DomainError.createAndLog(cause: .networking(.invalidReponse))
      }

      switch urlResponse.statusCode {
      case 401:
        throw DomainError.createAndLog(cause: .networking(.unauthorized))
      case 408:
        throw DomainError.createAndLog(cause: .networking(.timeoutError))
      case 400..<500:
        throw DomainError.createAndLog(cause: .networking(.clientError))
      case 500..<600:
        throw DomainError.createAndLog(cause: .networking(.serverError))

      default:
        break
      }

      return try JSONDecoder.decoder.decode(RequestedObject.self, from: data.0)
    }

    return .init(
      fetchAllRockets: {
        let url = try RocketAPI.rockets.get()

        return RocketConverter.convertToDomainModel(
          from: try await performRequest(from: url)
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
