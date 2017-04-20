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

protocol CustomCellUpdater {
    func updateTableView()
}

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var addAsFriend: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var unFriendBtn: UIButton!
    
    var uId:String!
    let userFriendRef = FIRDatabase.database().reference().child("users")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var delegate: CustomCellUpdater?


    @IBAction func AddFriend(_ sender: Any) {
        let currentTime = Date()
        let dateFormat = DateFormatter()
        
        dateFormat.timeStyle = .medium
        dateFormat.dateStyle = .medium
    //self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").child(self.uId).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
    //self.userFriendRef.child(self.uId).child("Friends").child("pendingRequests").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
        
        
self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("pendingRequests").child(self.uId).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
        self.userFriendRef.child(self.uId).child("Friends").child("friendRequests").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["timestamp": dateFormat.string(from: currentTime)])
        
        self.addAsFriend.isEnabled = false;
        self.addAsFriend.isHidden = true;
        self.removeFromSuperview()
        //delegate?.updateTableView()
        
        
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
        //delegate?.updateTableView()
    }
    
    
    @IBAction func RejectFriend(_ sender: UIButton) {
        
        self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").child(self.uId).removeValue();
        self.userFriendRef.child(self.uId).child("Friends").child("pendingRequests").child((FIRAuth.auth()?.currentUser?.uid)!).removeValue();
        
        self.removeFromSuperview()
        //delegate?.updateTableView()

        
    }
    
    @IBAction func Unfriend(_ sender: UIButton) {
        
        self.userFriendRef.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("myFriends").child(self.uId).removeValue();
        self.userFriendRef.child(self.uId).child("Friends").child("myFriends").child((FIRAuth.auth()?.currentUser?.uid)!).removeValue();
        
        self.removeFromSuperview()
        //delegate?.updateTableView()
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

