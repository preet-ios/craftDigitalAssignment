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
            "isCoding": true
        ]
        
        do {
            let encoder = URLParameterEncoder()
            try encoder.encode(request: &urlRequest, with: parameters)
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }

            let expectedURL = "https:www.google.com/?name=Preet&email=preet%2540gmail.com&userID=1&isCoding=true"
            XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
        }catch {
            
        }
    }
}

