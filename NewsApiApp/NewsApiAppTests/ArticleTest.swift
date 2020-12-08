//
//  ArticleTest.swift
//  NewsApiAppTests
//
//  Created by Josh Barker on 08/12/2020.
//

import XCTest

class ArticleTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let theTitle = "title"
        let theDescr = "description"
        let theAuthor = "author"
        let theContent = "content"
        let theSourceName = "The Times"
        let theUrl = URL.init(string: "https://www.google.com")
        let theImageUrl = URL.init(string: "https://www.mynicepics.com")
        
        let thePubDate = Date.init()
        
        let article = Article.init(theTitle: theTitle, theDescr: theDescr, theAuthor: theAuthor, theContent: theContent, thePubDate: thePubDate, theUrl: theUrl!, theImageUrl: theImageUrl!, theSource: theSourceName)
        
        
        XCTAssertNotNil(article)
        
        XCTAssertTrue(article.title == "title")
        XCTAssertTrue(article.descr == "description")
        XCTAssertTrue(article.author == "author")
        XCTAssertTrue(article.content == "content")
        
        XCTAssertTrue(article.source == "The Times")
        
        XCTAssertTrue(article.url?.absoluteString == "https://www.google.com")
        XCTAssertTrue(article.imageUrl?.absoluteString == "https://www.mynicepics.com")

        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
