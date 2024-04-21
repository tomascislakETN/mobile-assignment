import CoreToolkit
import Dependencies
import Foundation

public extension NetworkingClient {
  static var liveValue: Self {
    .init(
      request: { url in
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

        return data.0
      }
    )
  }
}

public extension NetworkingClient {
  func performRequest<RequestedObject: Decodable>(from url: URL) async throws -> RequestedObject {
    @Dependency(\.jsonDecoder) var jsonDecoder

    let data = try await self.request(url)

    return try jsonDecoder.decode(RequestedObject.self, from: data)
  }
}
