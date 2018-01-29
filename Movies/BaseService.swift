//
//  APIError.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import SwiftyJSON
import Alamofire

protocol ResponseDelegate {
    func success(type: ResponseType)
    func failure(type: ResponseType, errorType: APIError)
}

enum APIError {
    case noInternet, serverError, canceled, notFound, other
    var description: String {
        switch self {
        case .noInternet: return L10n.Default.noConnection
        case .serverError: return L10n.Default.serverError
        case .canceled: return L10n.Default.requestCanceled
        case .notFound: return L10n.Default.notFound
        case .other: return L10n.Default.tryAgain
        }
    }
    
    var error: NSError {
        return NSError(domain:"", code:0, userInfo:nil)
    }
    
    static func getErrorType(_ statusCode: Int)-> APIError {
        switch statusCode {
        case 500...599:
            return .serverError
        case 404:
            return .notFound
        case -999:
            return .canceled
        case -1009:
            return .noInternet
        default:
            return .other
        }
    }
}

class BaseService {
    private func getStatusCode<T: Any>(response: DataResponse<T>) -> Int {
        if let httpResponse = response.response {
            return httpResponse.statusCode
        }
        if let resultError = response.result.error as? URLError {
            return resultError.errorCode
        }
        return 404
    }
    
    func getError<T: Any>(response: DataResponse<T>) -> APIError {
        let statusCode = self.getStatusCode(response: response)
        let errorType = APIError.getErrorType(statusCode)
        return errorType
    }
}
