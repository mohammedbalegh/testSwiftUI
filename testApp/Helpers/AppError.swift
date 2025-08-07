
import Foundation

enum AppError: Error {
    case networkError(NetworkError)
    case unknownError(Error)

    var presentableMessage: String {
        switch self {
        case .networkError(let error):
            return error.specificError?.errorDescription ?? Localizer.networkError
        case .unknownError(let error):
            return error.localizedDescription
        }
    }
}
