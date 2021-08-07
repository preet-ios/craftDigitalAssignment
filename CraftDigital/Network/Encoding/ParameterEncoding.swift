//
//  ParameterEncoding.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

public typealias Parameters = [String: Any]

protocol ParameterEncoder {
    func encode(request: inout  URLRequest,with parameters: Parameters) throws
}
