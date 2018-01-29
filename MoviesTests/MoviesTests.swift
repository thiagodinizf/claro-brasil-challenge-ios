//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Thiago Diniz on 25/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Alamofire
import SwiftyJSON
import XCTest
@testable import Movies

class MoviesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
   
    func testSearchMovie() {
        let e = expectation(description: "Alamofire")
        MovieAPI.search(query: "Dunkirk").validate().responseJSON { (response: DataResponse<Any>) in
            do {
                if let data = response.data {
                    let json = try! JSON(data: data)
                    let value = json["total_results"].intValue
                    XCTAssertEqual(value, 5, "5 movies found!")
                }
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
