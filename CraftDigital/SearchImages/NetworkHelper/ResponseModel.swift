//
//  ResponseModel.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

struct SearchApiResponse {
    let type: String?
    let totalCount: Int?
    let value: [SearchResult]?
}

extension SearchApiResponse: Codable {}

struct SearchResult {
    let url: String?
    let thumbnail: String?
    let title: String?
    let name: String?
}

extension SearchResult: Codable {}
