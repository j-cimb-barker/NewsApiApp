//
//  NewsApiApp
//
//  Created by Josh Barker on 08/12/2020.
//  Copyright © 2020 Talking Cucumber Ltd. All rights reserved.
//

import Foundation

class Logging {
    
    class func JLog(message: String, functionName: String = #function, fileName: String = #file, lineNum: Int = #line) {
        
        NSLog ("\(fileName): \(functionName): \(lineNum): \(message)")
    }
    
}
