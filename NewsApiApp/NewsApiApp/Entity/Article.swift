//
//  Article.swift
//  NewsApiApp
//
//  Created by Josh Barker on 08/12/2020.
//

import Foundation

// models an Article from News API
// Note, not all fields are parsed
class Article: NSObject {

    var title = ""
    
    var descr = ""
    
    var author = ""
    
    var content = ""
    
    var pubDate = Date()
    
    var url:URL?
    
    var imageUrl:URL?
    
    var source = ""
    
    // for testing, etc.
    override init() {
        
    }
    
    init (theTitle: String, theDescr: String, theAuthor: String, theContent: String, thePubDate: Date, theUrl: URL, theImageUrl: URL, theSource: String) {
        
        self.title = theTitle
        self.descr = theDescr
        self.author = theAuthor
        self.content = theContent
        self.pubDate = thePubDate
        
        self.url = theUrl
        self.imageUrl = theImageUrl

        self.source = theSource
        
    }
    
}
