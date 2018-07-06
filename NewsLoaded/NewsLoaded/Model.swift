//
//  Model.swift
//  NewsLoaded
//
//  Created by iMaxiOS on 7/6/18.
//  Copyright © 2018 Maxim Granchenko. All rights reserved.
//

import Foundation

class Model {
    
    private var dataJSON: Data!
    
    var newsArray: [[String: Any]] {
        if dataJSON == nil {
            return []
        }
        
        do {
            if let dict = try JSONSerialization.jsonObject(with: dataJSON, options: .allowFragments) as? Dictionary<String, Any> {
                if let array = dict["articles"] as? [Dictionary<String, Any>] {
                    return array
                }
            }
        }catch {
            print("\(error.localizedDescription)")
        }
        return []
    }
    
    static var nNewsLoaded = Notification.Name("nNewsLoaded")
    
    func loadNewsJSON() {
        let stringURL = "http://jsonviewer.stack.hu/#http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=33ddf8671707455daf5c4348e0cacee7"
        let url = URL(string: stringURL)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, responce, err) in
            if err != nil {
                print("Error download news: \(err?.localizedDescription ?? "")")
                return
            }
            
            if (responce as! HTTPURLResponse).statusCode == 200 {
                if data != nil {
                    self.dataJSON = data!
                }
            }
            
            NotificationCenter.default.post(name: Model.nNewsLoaded, object: nil)
        }
        
        task.resume()
    }
}
