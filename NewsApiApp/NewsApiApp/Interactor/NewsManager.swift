//
//  NewsManager.swift
//  NewsApiApp
//
//  Created by Josh Barker on 08/12/2020.
//

import Foundation

class NewsManager: NSObject {

    let API_KEY = "899a60f2bece4e36815186c230242d88"
    
    @objc
    static let shared = NewsManager ()
 
    func convertDictionaryToArticle (theDict: [String: Any?]) -> Article? {
        
        guard let theTitle = theDict["title"] as? String else {return nil}
        
        guard let theDescr = theDict["description"] as? String else {return nil}
        
        var theAuthor = ""
        
        // author is optional
        if theDict["author"] != nil {
            let theAuthorStr = theDict["author"] as? String
            
            if theAuthorStr != nil {
                theAuthor = theAuthorStr!
            }
        }

        guard let theContent = theDict["content"] as? String else {return nil}
        
        guard let theUrlStr = theDict["url"] as? String else {return nil}
        guard let theUrl = URL.init(string: theUrlStr) else {return nil}
        
        guard let theImgUrlStr = theDict["urlToImage"] as? String else {return nil}
        guard let theImgUrl = URL.init(string: theImgUrlStr) else {return nil}
        
        guard let theDateStr = theDict["publishedAt"] as? String else {return nil}
        let date = Date.dateFromISOString (string: theDateStr)
        
        guard date != nil else {
            return nil
        }
        
        
        guard let theSourceObj = theDict["source"] as? [String:Any?] else {return nil}
        guard let theSourceName = theSourceObj["name"] as? String else {return nil}

        let article = Article.init(theTitle: theTitle, theDescr: theDescr, theAuthor: theAuthor, theContent: theContent, thePubDate: date!, theUrl: theUrl, theImageUrl: theImgUrl, theSource: theSourceName)
        
        return article
    }
    
    func getNewsArticles (keyword: String, language: String, completionHandler: @escaping (_ errorStr: String, _ newsArticles: [ Article ]) ->()){

        let escKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let escLang = language.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if escKeyword == nil {
            completionHandler ("Keyword can't be escaped", [Article] ())
            return
        }
        
        if escLang == nil {
            completionHandler ("Language can't be escaped", [Article] ())
            return
        }
        
        NewsManager.shared.getNews(keyword: escKeyword!, language: escLang!) { (errorStr: String, _ articles: [ [String : Any?] ]) in
            
            var articlesGot = [Article] ()
            
            for article in articles {
                
                //let articleO = Article.init(theDict: article)
                
                let articleO = self.convertDictionaryToArticle(theDict: article)
                
                if articleO != nil {
                    articlesGot.append(articleO!)
                }
                
            }
            
            completionHandler (errorStr, articlesGot)
        }
        
    }
        
    // gets a list of dictonaries from the api
    func getNews (keyword: String, language: String, completionHandler: @escaping (_ errorStr: String, _ articles: [ [String : Any?] ]) ->()){
        
        let session = URLSession.shared
        
        let url = URL(string: "https://newsapi.org/v2/everything?q=" + keyword + "&language=" + language + "&apiKey=" + API_KEY)
        
        let emptyArticles = [ [String : Any?] ] ()
        
        Logging.JLog(message: "url : \(String(describing: url))")
        
        let task = session.dataTask(with: url!, completionHandler: { data, response, error in

            if error != nil {
                completionHandler (error!.localizedDescription, emptyArticles)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                
                Logging.JLog(message: "Server error")
                completionHandler ("Server error", emptyArticles)
                return
            }

            Logging.JLog(message: "statusCode : \(response.statusCode)")
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                
                let jsonDict = json as? [String:Any]
                
                if jsonDict != nil {
                    
                    Logging.JLog(message: "jsonDict : \(String(describing: jsonDict))")
                    
                    if jsonDict! ["articles"] != nil {
                        let articles = jsonDict! ["articles"]  as! [ [String : Any?] ]
                        
                        Logging.JLog(message: "articles : \(articles.count)")
                        completionHandler ("", articles)
                        return
                    } else {
                        // might be slow news day
                        completionHandler ("", emptyArticles)
                        return
                    }
                    
                } else {
                    completionHandler ("", emptyArticles)
                    return
                }
                
            } catch {
                Logging.JLog(message: "JSON error: \(error.localizedDescription)")
                completionHandler (error.localizedDescription, emptyArticles)
            }
            
        })

        task.resume()
        
        
    }
    
}
