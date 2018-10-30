//
//  noteAppTests.swift
//  noteAppTests
//
//  Created by Marcel Harvan on 2018-10-28.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import XCTest
@testable import noteApp

class noteAppTests: XCTestCase {
    
    var sessionUnderTest: URLSession!

    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }

    var dataService = DataService.instance
    
    // Test of Status Code after calling BASE_API_URL
    
    func testStatusCode200ListOfNotes(){
        guard let url = URL(string: BASE_API_URL) else {return}
        let promise = expectation(description: "Status code: 200")
        let dataTask = sessionUnderTest.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                
                // Status Code 200
                
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
}
