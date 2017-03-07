//
//  SecondViewController.swift
//  HomeFeature Tab
//
//  Created by harpreet singh on 2017-02-28.
//  Copyright © 2017 assignment2. All rights reserved.
//

import UIKit


struct UserProfile {
    
    
    var fullname: String = ""
    var phoneNumber: String = ""
    var profileImage: String = ""
    var username: String = ""
    var uId: String = ""
    var key: String = ""
    func getDict() -> [String:Any] {
        let dict = ["username": self.username,
                    "fullname": self.fullname,
                    "profileImage":self.profileImage,
                    "phoneNumber":self.phoneNumber,
                    "uId":self.uId
            
        ]
        return dict
    }
}
struct UserPosts {
    
    var author: String = ""
    var likes: Int
    var pathToImage: String = ""
    var postId: String = ""
    var userId: String = ""
    var key: String = ""
    func getDict() -> [String:Any] {
        let dict = ["author": self.author,
                    "likes": self.likes,
                    "pathToImage":self.pathToImage,
                    "postId":self.postId,
                    "userId":self.userId
            
        ] as [String : Any]
        return dict
    }
}

class uProfile: NSObject{
    
    var fullname: String?
    var phoneNumber: String?
    var profileImage: String?
    var username: String?
    var uId: String?
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

