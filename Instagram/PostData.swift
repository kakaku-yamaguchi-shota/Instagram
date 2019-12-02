//
//  PostData.swift
//  Instagram
//
//  Created by 山口 彰太 on 2019/11/26.
//  Copyright © 2019 shouta.yamaguchi4. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [Dictionary<String, String>] = []

    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key

        let valueDictionary = snapshot.value as! [String: Any]

        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)

        self.name = valueDictionary["name"] as? String
        self.caption = valueDictionary["caption"] as? String

        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)

        if let comments = valueDictionary["comments"] as? [Dictionary<String, String>] {
            self.comments = comments
        }

        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }

        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
    }
}
