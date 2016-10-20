//
//  GiffelAPI.swift
//  Giffel
//
//  Created by Tom Bakker on 04-10-16.
//  Copyright © 2016 Fontys. All rights reserved.
//

import UIKit
import Alamofire

class GiffelAPI {
    
    class func retrieveGuid(completion: @escaping ((String) -> (Void))){
        
        let defaults = UserDefaults.standard
        let url = "https://warm-gorge-21566.herokuapp.com/users/create.json"
        var guid: String?
        
        if defaults.object(forKey: "deviceGuid") != nil {
            guid = defaults.object(forKey: "deviceGuid") as! String?
            completion(guid!)
        } else {
            Alamofire.request(url).responseJSON {handler in
                guard let responseJSON = handler.result.value as? [String: Any] else {
                    completion("")
                    return
                }

                guid = responseJSON["guid"] as! String?
                defaults.set(guid, forKey: "deviceGuid")
                completion(guid!)
            }
        }
    }
    
    class func retrievePopular(completion: @escaping (([Gif]) -> (Void))){
        let url = "https://warm-gorge-21566.herokuapp.com/gifs.json"
        
        Alamofire.request(url).responseJSON {handler in
            guard let responseJSON = handler.result.value as? [[String: Any]] else {
                completion([])
                return
            }
            
            let gifs = parse(gifData: responseJSON)
            completion(gifs)
        }
    }
    
    class func retrieveGifsWith(tag: String, completion: @escaping (([Gif]) -> (Void))){
        let escapedTag = tag.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? tag
        let url = "https://warm-gorge-21566.herokuapp.com/tags/" + escapedTag + ".json"
        
        Alamofire.request(url).responseJSON {handler in
            guard let responseJSON = handler.result.value as? [[String: Any]] else {
                completion([])
                return
            }
            
            let gifs = parse(gifData: responseJSON)
            completion(gifs)
        }

    }
    
    class func retrieveAllTags(completion: @escaping (([Tag]) -> (Void))){
        let url = "https://warm-gorge-21566.herokuapp.com/tags/index.json"
        
        Alamofire.request(url).responseJSON {handler in
            guard let responseJSON = handler.result.value as? [[String: Any]] else
            {
                completion([])
                return
            }
            
            var tags = [Tag]()
            for item in responseJSON{
                let id: Int = item["id"] as! Int
                let name: String = item["name"] as! String
                let taggings: Int = item["taggings_count"] as! Int
                tags.append(Tag(id: id, name: name, taggings: taggings))
            }
            
            completion(tags)
        }
    }
    
    class func like(gif: Gif, guid: String){
        if let gifID = gif.id {
            let url = "https://warm-gorge-21566.herokuapp.com/gifs/vote?gif=\(gifID)&guid=\(guid)"
            
            Alamofire.request(url).response(completionHandler: { (response) in
                print(response)
            })
        }
        
    }
    
    class func parse(gifData: [[String: Any]]) -> [Gif]{
        var gifs = [Gif]()
        
        for data in gifData {
            gifs.append(Gif(data: data))
        }
        
        return gifs
        
    }
}
