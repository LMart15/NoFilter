//
//  SuggestFriendsTableViewCell.swift
//  NoFilter
//
//  Created by CSI Admin on 2017-04-19.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class SuggestFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var addAsFriend: UIButton!
    @IBOutlet weak var profileImage: UIButton!
    
    
    var uId:String!
    let userFriendRef = FIRDatabase.database().reference().child("users")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func AddFriend(_ sender: UIButton) {
    
        let currentTime = Date()
        let dateFormat = DateFormatter()
        
        dateFormat.timeStyle = .medium
        dateFormat.dateStyle = .medium
//        self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").child(self.uId).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
//        self.userFriendRef.child(self.uId).child("Friends").child("pendingRequests").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
//        
        
                self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("pendingRequests").child(self.uId).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
                self.userFriendRef.child(self.uId).child("Friends").child("friendRequests").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
        
        //self.addAsFriend.isEnabled = false;
        //self.addAsFriend.isHidden = true;
        self.removeFromSuperview()
    
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
