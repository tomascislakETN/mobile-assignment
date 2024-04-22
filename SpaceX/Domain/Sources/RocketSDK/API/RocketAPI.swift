import CoreToolkit
import Foundation

enum RocketAPI {
  private static let baseURL = "https://api.spacexdata.com"

  static var rockets: Result<URL, DomainError> {
    URL(string: baseURL + "/v3/rockets")
      .map(Result.success)
    ?? .failure(.createAndLog(cause: .networking(.urlError)))
  }
}
