//
//  PlanAPIError.swift
//  Stardust
//
//  Created by Soom on 6/26/24.
//

import Foundation

enum PlanAPIError: Error{
    case invaildData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    
    var customDescripion: String{
        switch self{
        case .invaildData:
            return "잘못된 데이터"
        case .jsonParsingFailure:
            return "Failed to parse JSON"
        case .requestFailed(description: let description):
            return "Requeest failed: \(description)"
        case .invalidStatusCode(statusCode: let statusCode):
            return "Invalid staus code: \(statusCode)"
        case .unknownError(error: let error):
            return "An unknown error occured: \(error.localizedDescription)"
        }
    }
}
