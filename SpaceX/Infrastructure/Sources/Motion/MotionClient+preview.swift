#if DEBUG
public extension MotionClient {
  static var previewValue: Self {
    .init(
      startAccelerometerUpdates: {
        .init {
          $0.yield(.init(x: 1, y: 1, z: 1))
          $0.finish()
        }
      }
    )
  }
}
#endif
