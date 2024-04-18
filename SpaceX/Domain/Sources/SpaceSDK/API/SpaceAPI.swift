import Foundation

enum SpaceAPI {
  private static let baseURL = "https://api.spacexdata.com"

  static let rockets = URL(string: baseURL + "/v3/rockets")
}
