//
//  FriendsRequestsViewController.swift
//  NoFilter
//
//  Created by CSI Admin on 2017-04-19.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD


class FriendsRequestsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var friendsRequestsTableView: UITableView!
    var friendRequestsList = [UserProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriendRequests();
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
       // self.friendsRequestsTableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return friendRequestsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell=tableView.dequeueReusableCell(withIdentifier: "FCell", for: indexPath) as! FriendsRequestsTableViewCell
            
            let user = cell.profileName as! UILabel
            let imageView = cell.profileImage as! UIButton
            
            user.text = self.friendRequestsList[indexPath.row].fullName
            
            let url = NSURL(string: self.friendRequestsList[indexPath.row].profileImage)
            let data = NSData(contentsOf: url! as URL)
            if data != nil {
                //                imageView.image = UIImage(data: data! as Data)?.resized(withPercentage: 0.1)
                imageView.setImage(UIImage(data: data! as Data), for: UIControlState.normal)
                imageView.layer.cornerRadius = imageView.frame.width/2.0
                imageView.layer.masksToBounds = true
            }
            
        
            cell.uId = self.friendRequestsList[indexPath.row].uId
           // SVProgressHUD.dismiss()
            return cell
    }
    

    
    
    func fetchFriendRequests() {
        
        var friendRequestProfile = UserProfile()
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").observe(.value, with: {(friendsReqSnapshot) in
            self.friendRequestsList.removeAll()
            if let friendReq = friendsReqSnapshot.value as? [String:AnyObject]
            {
                for reqFriendId in friendReq
                {
                    
                    FIRDatabase.database().reference().child("users").child(reqFriendId.key).observe(.value, with:
                        { (reqFriendProfileSnapshot) in
                            
                            if let reqFriend = reqFriendProfileSnapshot.value as? [String:AnyObject]
                            {
                                
                                friendRequestProfile.fullName = reqFriend["fullName"] as! String
                                if((reqFriend["profileImage"]) != nil){
                                    friendRequestProfile.profileImage = reqFriend["profileImage"] as! String
                                }
                                
                                if((reqFriend["uId"]) != nil){
                                    friendRequestProfile.uId = reqFriend["uId"] as! String
                                }
                                print("Friends Request",friendRequestProfile.uId )
                                self.friendRequestsList.append(friendRequestProfile)
                            }
                    })
                }
            }
            DispatchQueue.main.async
                {
                    self.friendsRequestsTableView.reloadData()
            }
        } , withCancel: nil)
    }
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
