//
//  MyFriendsTableViewCell.swift
//  NoFilter
//
//  Created by CSI Admin on 2017-04-19.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase



class MyFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var unFriendBtn: UIButton!
    @IBOutlet weak var profileImage: UIButton!
    
    
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

    @IBAction func Unfriend(_ sender: UIButton) {
    
        self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("myFriends").child(self.uId).removeValue();
        self.userFriendRef.child(self.uId).child("Friends").child("myFriends").child((FIRAuth.auth()?.currentUser?.uid)!).removeValue();
        
        self.removeFromSuperview()
    
    }
    
    
}
