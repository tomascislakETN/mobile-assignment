import Motion

enum RocketStateConverter {
  static func domainModel(from external: MotionPoint) -> RocketState {
    abs(external.z) < 0.5
    ? .flying
    : .ready
  }
}
