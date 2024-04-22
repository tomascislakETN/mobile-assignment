import SwiftUI

public struct ListCell: View {
  let image: Image
  let title: String
  let description: String

  public init(
    image: Image,
    title: String,
    description: String
  ) {
    self.image = image
    self.title = title
    self.description = description
  }

  public var body: some View {
    HStack(spacing: .xSmall) {
      image

      VStack(alignment: .leading, spacing: .xxSmall) {
        Text(title)
          .font(.title3.weight(.bold))
          .foregroundColor(.Text.primary)

        Text(description)
          .font(.subheadline)
          .foregroundColor(.Text.secondary)
      }

      Spacer()

      Image(systemName: "chevron.right")
        .foregroundColor(.gray)
    }
  }

  static var placeholder: Self {
    .init(
      image: .rocket,
      title: String(repeating: " ", count: Int.random(in: 8..<10)),
      description: String(repeating: " ", count: Int.random(in: 15..<20))
    )
  }
}
