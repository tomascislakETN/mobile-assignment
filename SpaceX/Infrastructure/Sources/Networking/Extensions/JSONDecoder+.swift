import Dependencies
import Foundation

extension JSONDecoder {
  static var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)

    return decoder
  }
}

extension JSONEncoder {
  static var encoder: JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(DateFormatter.yyyyMMdd)

    return encoder
  }
}

private extension DateFormatter {
  static let yyyyMMdd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
  }()
}

// MARK: - Dependency

extension JSONDecoder: DependencyKey {
  public static var liveValue: JSONDecoder {
    JSONDecoder.decoder
  }
}

public extension DependencyValues {
  var jsonDecoder: JSONDecoder {
    get { self[JSONDecoder.self] }
    set { self[JSONDecoder.self] = newValue }
  }
}
