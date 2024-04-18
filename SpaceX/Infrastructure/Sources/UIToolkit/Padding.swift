import Foundation

public enum Padding {
  /// 4
  case xxxSmall
  /// 8
  case xxSmall
  /// 16
  case xSmall
  /// 24
  case small
  /// 32
  case medium
  /// 40
  case large
  /// 48
  case xLarge
  /// 56
  case xxLarge

  var value: CGFloat {
    switch self {
    case .xxxSmall:
      return 4
    case .xxSmall:
      return 8
    case .xSmall:
      return 16
    case .small:
      return 24
    case .medium:
      return 32
    case .large:
      return 40
    case .xLarge:
      return 48
    case .xxLarge:
      return 56
    }
  }
}
