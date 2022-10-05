//
//  Model.swift
//  NewApp
//
//  Created by Artem on 04.10.2022.
//  Copyright © 2022 Artem. All rights reserved.
//

import Foundation


var articles: [Article] = []
var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

func loadNews (completionHandler: (()->Void)?) {
    let pageSize = 20
    let page = 1
    
    let url = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2022-10-04&sortBy=popularity&pageSize=20&page=1&apiKey=7c03338095e94f459c585ffe70a41027")
    let session = URLSession (configuration: .default)
    
    let downloadTask = session.downloadTask(with: url!) { (urlFile, responce, error) in
        if urlFile != nil {
            try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
            parseNews()
            completionHandler?()
        }
    }
    
    downloadTask.resume()
}


func parseNews() {
    let data = try? Data(contentsOf: urlToData)
    if data == nil {
        return
    }

    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    if rootDictionaryAny == nil {
        return
    }

    let rootDictionary = rootDictionaryAny as? Dictionary<String, Any>
    if rootDictionary == nil {
        return
    }

    if let array = rootDictionary!["articles"] as? [Dictionary<String, Any>] {
        var returnArray: [Article] = []
        for dict in array {
            let newArticle = Article(dictionary: dict)
            returnArray.append(newArticle)
        }
        articles = returnArray
    }
}
