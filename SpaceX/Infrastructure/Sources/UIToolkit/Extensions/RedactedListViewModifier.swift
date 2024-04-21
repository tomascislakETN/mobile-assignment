import SwiftUI

struct RedactedListViewModifier<Data, RedactedView: View>: ViewModifier {
  let data: [Data]
  @ViewBuilder let redactedView: () -> RedactedView

  func body(content: Content) -> some View {
    ZStack {
      content
        .isHidden(data.isEmpty, remove: true)

      redactedView()
        .redacted(reason: .placeholder)
        .isHidden(!data.isEmpty, remove: true)
    }
  }
}

public extension View {
  func redacted<Data>(
    data: [Data]
  ) -> some View {
    modifier(
      RedactedListViewModifier(
        data: data,
        redactedView: {
          List {
            ForEach(0..<4, id: \.self) { _ in
              ListCell.placeholder
            }
          }
        }
      )
    )
  }
}
