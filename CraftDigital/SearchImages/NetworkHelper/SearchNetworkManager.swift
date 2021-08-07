//
//  SearchNetworkManager.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

enum NetworkResponse:String {
    case success
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

protocol SearchManaging {
    func getSearch(page: Int,query: String, pageSize: Int, autoCorrect: Bool, completion: @escaping (_ movie: [SearchResult]?,_ error: String?)->())
}

struct SearchManager: SearchManaging {
    func getSearch(page: Int, query: String, pageSize: Int, autoCorrect: Bool, completion: @escaping ([SearchResult]?, String?) -> ()) {
        
    }
}
