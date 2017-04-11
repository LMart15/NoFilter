//
//  SecondViewController.swift
//  HomeFeature Tab
//
//  Created by harpreet singh on 2017-02-28.
//  Copyright © 2017 assignment2. All rights reserved.
//

import UIKit
import Firebase

struct UserProfile {
    
    var fullName: String = ""
    var phoneNumber: String = ""
    var profileImage: String = ""
    
    var username: String = ""
    var uId: String = ""
    var email: String = ""
    var status: String = ""
    var key: String = ""
    func getDict() -> [String:Any] {
        let dict = ["username": self.username,
                    "fullname": self.fullName,
                    "profileImage":self.profileImage,
                    "phoneNumber":self.phoneNumber,
                    "email":self.email,
                    "uId":self.uId
            
        ]
        return dict
    }
}

struct UserPost {
    
    var author: String = ""
    var likes: String = ""
    var pathToImage: String = ""
    var postId: String = ""
    var uId: String = ""
    var timestamp: String = ""
    var key: String = ""
    var peopleWhoLike:[String] = [String]()
    func getDict() -> [String:Any] {
        let dict = ["displayName": self.author,
                    "likes": self.likes,
                    "pathToImage":self.pathToImage,
                    "postId":self.postId,
                    "uId":self.uId,
                    "timestamp":self.timestamp,
                    "key":self.key
        ]
        return dict
    }
}


struct UserComments {
    
    var comment: String=""
    var commentedBy: String = ""
    var timestamp: String = ""
    var postId: String = ""
    var type: String = ""
    
    func getDict() -> [String:AnyObject] {
        let dict = ["comment": self.comment,
                    "commentedBy": self.commentedBy,
                    "timestamp":self.timestamp,
                    "postId":self.postId,
                    "type":self.type
        ] as [String : Any]
        return dict as [String : AnyObject]
    }
}


class uProfile: NSObject{
    
    var fullname: String?
    var phoneNumber: String?
    var profileImage: String?
    var username: String?
    var uId: String?
}

class uComments: NSObject{
    var comment: String?
    var commentedBy: String?
    var timestamp: String?
    var type: String?
}

class uPost: NSObject{
    
    var author: String?
    var likes: Int?
    var pathToImage: String?
    var postId: String?
    var userId: String?
}


class SecondViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

