//
//  HTTPTask.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case request
    case requestParamsAndHeaders(urlParmams: Parameters?,
                                 headers: HTTPHeaders?)
}
