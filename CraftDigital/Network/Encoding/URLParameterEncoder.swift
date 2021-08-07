//
//  URLParameterEncoder.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    public func encode(request: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = request.url else { throw EncodingError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
    }
}

enum EncodingError: String, Error {
    case missingURL = "URL is nil."
}
