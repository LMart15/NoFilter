//
//  HomeHeaderCollectionReusableView.swift
//  NoFilter
//
//  Created by Lawrence Martin on 2017-04-13.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase

class HomeHeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var bio_txtview: UITextView!
    @IBOutlet weak var numPosts_lbl: UILabel!
    @IBOutlet weak var numFolllowers_lbl: UILabel!
    @IBOutlet weak var numFollowing_lbl: UILabel!
    
    var uProfile = [UserProfile]()
    var uPostsList = [UserPost]()
    var userCellPosts = UserPost()
    var refHandle: UInt!
    var ref: FIRDatabaseReference!
    var userProfile = UserProfile()
    var userRef: FIRDatabaseReference!
    var posts=Post()          //fetch array info from post class which fetch posts from database server
    var numPosts=[Post]()
    var postt:String?

    
    @IBAction func editProfileAction_btn(_ sender: UIButton) {
    }
    

}

