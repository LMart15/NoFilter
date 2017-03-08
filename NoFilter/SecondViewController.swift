//
//  SecondViewController.swift
//  HomeFeature Tab
//
//  Created by harpreet singh on 2017-02-28.
//  Copyright © 2017 assignment2. All rights reserved.
//

import UIKit



struct UserProfile {
    
    var fullName: String = ""
    var phoneNumber: String = ""
    var profileImage: String = ""
    var username: String = ""
    var uId: String = ""
    var email: String = ""
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
    var key: String = ""
    
    func getDict() -> [String:Any] {
        let dict = ["author": self.author,
                    "likes": self.likes,
                    "pathToImage":self.pathToImage,
                    "postId":self.postId,
                    "uId":self.uId
        ]
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

