//
//  NewsManagerTest.swift
//  NewsApiAppTests
//
//  Created by Josh Barker on 08/12/2020.
//

import XCTest

class NewsManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testConvertJsonToArticle () throws {
        
        let sampleDict = [
            "title" : "title",
            "description" : "description",
            "author" : "author",
            "content" : "content",
            "url" : "https://www.google.com",
            "urlToImage" : "https://www.mynicepics.com",
            "publishedAt" : "2020-11-24T14:30:01Z",
            "source" : [
                "name" : "The Times"
            ]
            
        ] as [String: Any?]
        
        let article = NewsManager.shared.convertDictionaryToArticle(theDict: sampleDict)
        
        
        XCTAssertNotNil(article)
        
        XCTAssertTrue(article?.title == "title")
        XCTAssertTrue(article?.descr == "description")
        XCTAssertTrue(article?.author == "author")
        XCTAssertTrue(article?.content == "content")
        
        XCTAssertTrue(article?.source == "The Times")
        
        XCTAssertTrue(article?.url?.absoluteString == "https://www.google.com")
        XCTAssertTrue(article?.imageUrl?.absoluteString == "https://www.mynicepics.com")

        let calendar = Calendar.current
        
        XCTAssertTrue(calendar.component(.year, from: article!.pubDate) == 2020)
        XCTAssertTrue(calendar.component(.month, from: article!.pubDate) == 11)
        XCTAssertTrue(calendar.component(.day, from: article!.pubDate) == 24)
        
        XCTAssertTrue(calendar.component(.hour, from: article!.pubDate) == 14)
        XCTAssertTrue(calendar.component(.minute, from: article!.pubDate) == 30)
        XCTAssertTrue(calendar.component(.second, from: article!.pubDate) == 1)
        
    }

    func testGetNews () throws {
        
        var exp:XCTestExpectation?
        
        exp = expectation(description: "got results")

        NewsManager.shared.getNewsArticles(keyword: "space", language: "en") { (errorStr: String, _ newsArticles: [ Article ]) in
            
            // might fail if no news
            XCTAssertTrue(newsArticles.count > 0)
            
            exp?.fulfill()
        }
        
        waitForExpectations(timeout: 100) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testGetNewsFromApi() throws {
        
        var exp:XCTestExpectation?
        
        exp = expectation(description: "got results")
        
        NewsManager.shared.getNews(keyword: "space", language: "en") { (errorStr: String, _ articles: [ [String : Any?] ]) in
            
            // might fail if no news
            XCTAssertTrue(articles.count > 0)

            var minChars = -1
            var maxChars = 0
            
            for article in articles {
                
                Logging.JLog(message: "article : \(article)")
                
                let articleUrlStr = article ["url"] as? String?
                let articleDescr = article ["description"] as? String?
                let articleTitle = article ["title"] as? String?
                let articleDateStr = article ["publishedAt"] as? String?

                XCTAssertTrue(articleDateStr != nil)
                
                Logging.JLog(message: "articleDescr.count : \(String(describing: articleDescr!?.count))")
                
                if articleDescr!!.count > maxChars {
                    maxChars = articleDescr!!.count
                }
                
                if articleDescr!!.count < minChars {
                    minChars = articleDescr!!.count
                }
                
                if minChars == -1 {
                    minChars = articleDescr!!.count
                }
                
                // I am not checking the content here as this can change...!
                Logging.JLog(message: "articleUrlStr : \(String(describing: articleUrlStr))")
                Logging.JLog(message: "articleDescr : \(String(describing: articleDescr))")
                Logging.JLog(message: "articleTitle : \(String(describing: articleTitle))")
                Logging.JLog(message: "articleDateStr : \(String(describing: articleDateStr))")

                let articleO = NewsManager.shared.convertDictionaryToArticle(theDict: article)
                Logging.JLog(message: "articleO : \(String(describing: articleO))")
                
                if articleO == nil {
                    Logging.JLog(message: "nil article")
                }
                
                // if the article is nil there was a problem parsing the json
                XCTAssertTrue(articleO != nil)
                
                
            }
            
            Logging.JLog(message: "minChars : \(minChars)")
            Logging.JLog(message: "maxChars : \(maxChars)")
            
            
            exp?.fulfill()
            
        }
        
        waitForExpectations(timeout: 100) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
