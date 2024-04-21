#if DEBUG
import Foundation

public extension NetworkingClient {
  static var previewValue: Self {
    .init(
      request: { _ in Data() }
    )
  }
}
#endif
