import Foundation

enum NetworkError: Error {
    case badUrl
    case requestError
    case parsingError(Error)
    case clientError
    case serverError
    case badJSON
    
}
