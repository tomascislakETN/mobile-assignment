import SwiftUI

public extension View {
  func padding(_ edges: Edge.Set, _ length: Padding) -> some View {
    padding(edges, length.value)
  }

  func padding(_ length: Padding) -> some View {
    padding(.all, length.value)
  }
}

public extension HStack where Content: View {
  // swiftlint:disable:next function_default_parameter_at_end
  init(
    alignment: VerticalAlignment = .center,
    spacing: Padding,
    @ViewBuilder content: () -> Content
  ) {
    self.init(alignment: alignment, spacing: spacing.value, content: content)
  }
}

public extension LazyHStack where Content: View {
  // swiftlint:disable:next function_default_parameter_at_end
  init(
    alignment: VerticalAlignment = .center,
    spacing: Padding,
    @ViewBuilder content: () -> Content
  ) {
    self.init(alignment: alignment, spacing: spacing.value, content: content)
  }
}

public extension VStack where Content: View {
  // swiftlint:disable:next function_default_parameter_at_end
  init(
    alignment: HorizontalAlignment = .center,
    spacing: Padding,
    @ViewBuilder content: () -> Content
  ) {
    self.init(alignment: alignment, spacing: spacing.value, content: content)
  }
}

public extension LazyVStack where Content: View {
  // swiftlint:disable:next function_default_parameter_at_end
  init(
    alignment: HorizontalAlignment = .center,
    spacing: Padding,
    @ViewBuilder content: () -> Content
  ) {
    self.init(alignment: alignment, spacing: spacing.value, content: content)
  }
}
