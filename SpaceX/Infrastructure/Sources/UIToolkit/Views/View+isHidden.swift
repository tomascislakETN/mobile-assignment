import SwiftUI

public extension View {
  @ViewBuilder
  func isHidden(_ hidden: Bool, remove: Bool = true) -> some View {
    if hidden {
      if !remove {
        self.hidden()
      }
    } else {
      self
    }
  }
}
