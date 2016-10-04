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
    
    class func retrievePopular(completion: @escaping (([Gif]) -> (Void))){
        let url = "https://warm-gorge-21566.herokuapp.com/gifs.json"
        
        Alamofire.request(url).responseJSON {handler in
            guard let responseJSON = handler.result.value as? [[String: Any]] else {
                completion([])
                return
            }
            
            print("JSON: \(responseJSON)")
            let gifs = parse(gifData: responseJSON)
            completion(gifs)
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
