public extension AsyncStream {
  static func just(_ value: Element) -> Self {
    .init {
      $0.yield(value)
      $0.finish()
    }
  }
}

public extension AsyncThrowingStream {
  static func just(_ value: Element) -> Self where Failure == (any Error) {
    AsyncThrowingStream {
      $0.yield(value)
      $0.finish()
    }
  }
}
