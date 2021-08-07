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

extension SearchApi {
    static let host : String = "contextualwebsearch-websearch-v1.p.rapidapi.com"
    static let baseURL = "https://contextualwebsearch-websearch-v1.p.rapidapi.com/"
    
    var path: String {
        "api/Search/ImageSearchAPI"
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
            "x-rapidapi-host": SearchApi.host
        ]
    }
}
