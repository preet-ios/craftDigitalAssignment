//
//  ParameterEncoding.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    func encode(request: inout  URLRequest,with parameters: Parameters) throws
}

struct ParameterEncoding {
    func encode(request: inout URLRequest,
                       paramaters urlParameters: Parameters?) throws {
        guard let urlParameters = urlParameters else { return }
        try URLParameterEncoder().encode(request: &request, with: urlParameters)    }
}
