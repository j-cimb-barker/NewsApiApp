//
//  DateUtilsTest.swift
//  NewsApiAppUITests
//
//  Created by Josh Barker on 08/12/2020.
//

import XCTest

class DateUtilsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseDate () throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let dateStr = "2020-11-24T14:30:01Z"
        
        let date = Date.dateFromISOString (string: dateStr)
        
        XCTAssertNotNil(date)
        
        let calendar = Calendar.current
        
        XCTAssertTrue(calendar.component(.year, from: date!) == 2020)
        XCTAssertTrue(calendar.component(.month, from: date!) == 11)
        XCTAssertTrue(calendar.component(.day, from: date!) == 24)
        
        XCTAssertTrue(calendar.component(.hour, from: date!) == 14)
        XCTAssertTrue(calendar.component(.minute, from: date!) == 30)
        XCTAssertTrue(calendar.component(.second, from: date!) == 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
