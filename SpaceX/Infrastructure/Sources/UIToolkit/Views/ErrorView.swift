import SwiftUI

public struct ErrorView: View {
  let okTapped: () -> Void

  public init(
    okTapped: @escaping () -> Void
  ) {
    self.okTapped = okTapped
  }

  public var body: some View {
    VStack(spacing: .xSmall) {
      Spacer()

      Text("Something went wrong")
        .font(.title.bold())
        .foregroundColor(.Text.primary)

      Image.rocketError
        .resizable()
        .scaledToFit()

      Spacer()

      Button(
        action: okTapped,
        label: {
          Text("OK")
            .font(.title3)
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.Brand.primary)
            .cornerRadius(16)
        }
      )
      .padding(.horizontal, .xSmall)
    }
    .padding(.bottom, .xSmall)
  }
}

#Preview {
  ErrorView(
    okTapped: {}
  )
}
