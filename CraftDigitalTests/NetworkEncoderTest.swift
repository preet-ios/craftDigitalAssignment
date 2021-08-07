//
//  NetworkEncoderTest.swift
//  CraftDigitalTests
//
//  Created by Simran on 07/08/21.
//

import XCTest
@testable import CraftDigital

final class CraftAPIClientTests: XCTestCase {
    
    func testURLEncoding() {
        guard let url = URL(string: "https:www.google.com/") else {
            XCTAssertTrue(false, "Could not instantiate url")
            return
        }
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = [
            "userID": 1,
            "name": "Preet",
            "email": "preet@gmail.com",
            "IsCoding": true
        ]
        
        do {
            let encoder = URLParameterEncoder()
            try encoder.encode(request: &urlRequest, with: parameters)
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }

            let expectedURL = "https:www.google.com/?Name=Preet&Email=preet%2540gmail.com&UserID=1&IsCoding=true"
            XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
        }catch {
            
        }
    }
}

