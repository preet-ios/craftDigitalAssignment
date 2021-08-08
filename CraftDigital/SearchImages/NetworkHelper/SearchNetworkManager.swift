//
//  SearchNetworkManager.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

protocol SearchManaging {
    func getSearch(page: Int,query: String, pageSize: Int, autoCorrect: Bool, completion: @escaping (_ apiResponse: SearchApiResponse?,_ error: String?)->())
}

struct SearchManager: SearchManaging {
    let router = Router<SearchApi>()
    
    func getSearch(page: Int, query: String, pageSize: Int, autoCorrect: Bool, completion: @escaping (SearchApiResponse?, String?) -> ()) {
            router.request(.search(page:page, query: query, pageSize: pageSize, autoCorrect: autoCorrect)) { data, response, error in
                
                if error != nil {
                    completion(nil, "Please check your network connection.")
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            let apiResponse = try JSONDecoder().decode(SearchApiResponse.self, from: responseData)
                            completion(apiResponse,nil)
                        }catch {
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
        
        private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
            switch response.statusCode {
            case 200...299: return .success
            case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
            case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
            case 600: return .failure(NetworkResponse.outdated.rawValue)
            default: return .failure(NetworkResponse.failed.rawValue)
            }
        }
    }
