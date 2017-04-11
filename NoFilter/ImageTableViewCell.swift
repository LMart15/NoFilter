//
//  ImageTableViewCell.swift
//  NoFilter
//
//  Created by Basil on 2017-03-30.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var addAsFriend: UIButton!
    var uId:String!
    let userFriendRef = FIRDatabase.database().reference().child("users")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func AddFriend(_ sender: Any) {
        let currentTime = Date()
        let dateFormat = DateFormatter()
        
        dateFormat.timeStyle = .medium
        dateFormat.dateStyle = .medium
        print((FIRAuth.auth()?.currentUser?.uid)!)
    self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").child(self.uId).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
    self.userFriendRef.child(self.uId).child("Friends").child("pendingRequests").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
        self.addAsFriend.isEnabled = false;
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
