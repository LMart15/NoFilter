//
//  FriendsRequestsTableViewCell.swift
//  NoFilter
//
//  Created by CSI Admin on 2017-04-19.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase


class FriendsRequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    
    
    
    var uId:String!
    let userFriendRef = FIRDatabase.database().reference().child("users")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func RejectFriend(_ sender: UIButton) {
        self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").child(self.uId).removeValue();
        self.userFriendRef.child(self.uId).child("Friends").child("pendingRequests").child((FIRAuth.auth()?.currentUser?.uid)!).removeValue();
        
        self.removeFromSuperview()
        
    }
    
    
    @IBAction func AcceptFriend(_ sender: UIButton) {
    
        let currentTime = Date()
        let dateFormat = DateFormatter()
        
        dateFormat.timeStyle = .medium
        dateFormat.dateStyle = .medium
        self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("myFriends").child(self.uId).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
        self.userFriendRef.child(self.uId).child("Friends").child("myFriends").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
        
        self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").child(self.uId).removeValue();
        self.userFriendRef.child(self.uId).child("Friends").child("pendingRequests").child((FIRAuth.auth()?.currentUser?.uid)!).removeValue();
        
        self.removeFromSuperview()

    
    }
}
