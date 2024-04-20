import SwiftUI

public struct Section<Content: View>: View {
  let title: String
  let content: () -> Content

  public init(
    title: String,
    content: @escaping () -> Content
  ) {
    self.title = title
    self.content = content
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: .xxSmall) {
      Text(title)
        .font(.title3.weight(.bold))
        .foregroundColor(.Text.primary)

      content()
    }
  }
}
