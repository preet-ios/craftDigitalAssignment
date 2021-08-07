//
//  SearchEndPoint.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

enum SearchApi {
    case search( page: Int, query: String, pageSize: Int, autoCorrect: Bool)
    // add more cases here
}

extension SearchApi: EndPointType {
    static let key : String = "5c1f6cf8efmshd778cf58e23b88dp1e58dfjsn94f75c119255"
    static let host : String = "contextualwebsearch-websearch-v1.p.rapidapi.com"
    
    var environmentBaseURL : String {
        "https://contextualwebsearch-websearch-v1.p.rapidapi.com/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        "api/Search/ImageSearchAPI"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .search(let page, let query,let pageSize,let  autoCorrect):
            return .requestParamsAndHeaders(urlParmams:["q": query,
                                                        "pageNumber": page,
                                                        "pageSize": pageSize,
                                                        "autoCorrect": autoCorrect],
                                            headers: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        return  [
            "x-rapidapi-key": SearchApi.key,
            "x-rapidapi-host": SearchApi.host
        ]
    }
}
