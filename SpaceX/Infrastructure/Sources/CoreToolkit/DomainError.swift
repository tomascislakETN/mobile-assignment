import Foundation

public struct DomainError: Error {
  // MARK: - Cause

  public enum ErrorCause: Equatable {
    case networking(NetworkingCause)
    case motionError
    case convertingToResultFailed
    case other

    public enum NetworkingCause: Equatable {
      case urlError
      case invalidReponse
      case unauthorized
      case timeoutError
      case clientError
      case serverError
    }
  }

  // MARK: - Properties

  public let cause: ErrorCause
  public let underlyingError: Error?
  public var debugDescription: String { generatedDebugMessage }

  // MARK: - Initializers

  public init(
    cause: ErrorCause,
    underlyingError: Error? = nil
  ) {
    self.cause = cause
    self.underlyingError = underlyingError
  }

  // MARK: - Helper methods

  private var generatedDebugMessage: String {
    var debugMessage = "cause: \(cause) - "

    if let underlyingError = underlyingError {
      debugMessage += "error: \(underlyingError.localizedDescription)"
    }

    return debugMessage
  }
}

extension DomainError {
  private var reportingError: NSError {
    .init(
      domain: String(reflecting: cause),
      code: 1,
      userInfo: [
        "description": "\(self)",
        "debugDescription": debugDescription
      ]
    )
  }

  public static func createAndLog(
    cause: ErrorCause,
    underlyingError: Error? = nil
  ) -> DomainError {
    let error = DomainError(cause: cause, underlyingError: underlyingError)
    print("[ERROR] ❌ \(error.reportingError)")

    return error
  }
}

extension DomainError: Equatable {
  public static func == (lhs: DomainError, rhs: DomainError) -> Bool {
    lhs.generatedDebugMessage == rhs.generatedDebugMessage
  }
}
