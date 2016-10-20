//
//  Gif.swift
//  Giffel
//
//  Created by Tom Bakker on 04-10-16.
//  Copyright © 2016 Fontys. All rights reserved.
//

import UIKit

class Gif {
    let id: Int?
    let imageUrl: String?
    let tags: [String]?
    let likes: Int?
    var shareUrl: String?
    
    init(id: Int, imageUrl: String, tags: [String]) {
        self.id = id
        self.imageUrl = imageUrl
        self.tags = tags
        self.shareUrl = "https://warm-gorge-21566.herokuapp.com"
        self.likes = 0
    }
    
    init(data: [String: Any]) {
        //TODO
        self.id = data["id"] as? Int
        self.imageUrl = data["image"] as? String
        self.tags = data["tag_list"] as? [String]
        self.shareUrl = data["url"] as? String
        self.likes = data["likes"] as? Int
    }
}

// Example JSON
//{
//    "created_at":
//    "2016-10-03T11:45:26.474Z",
//    "id":
//    16,
//    "image":
//    "//s3-us-west-2.amazonaws.com/fontysgiffel/gifs/images/000/000/016/original/obama-dankjewel.gif?1475495126",
//    "tag_list":
//    [
//    "obama",
//    "dankjewel",
//    "rijksmuseum"
//    ],
//    "updated_at":
//    "2016-10-03T11:45:26.474Z",
//    "url":
//    "https://warm-gorge-21566.herokuapp.com/gifs/16.json"
//}
