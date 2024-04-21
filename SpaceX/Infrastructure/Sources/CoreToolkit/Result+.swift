public extension Result where Failure == DomainError {
  init(catching body: () async throws -> Success) async {
    do {
      self = .success(try await body())
    } catch {
      if let err = error as? DomainError {
        self = .failure(err)
      } else {
        self = .failure(DomainError(cause: .convertingToResultFailed, underlyingError: error))
      }
    }
  }
}

public extension Result {
  var successValue: Success? {
    guard case let .success(success) = self else {
      return nil
    }

    return success
  }
}
