//
//  FriendsViewController.swift
//  NoFilter
//
//  Created by Basil on 2017-03-28.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FriendsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var suggestedFriendsList = [UserProfile]()
    var myFriendsList = [UserProfile]()
    var friendRequestsList = [UserProfile]()
    
    let myFriendDemoString:[String] = ["My Chingu 1"," My Chingu 2","My Chingu 3"]
    let friendRequestString:[String] = ["New Chingu 1"," New Chingu 2","New Chingu 3"]
    
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("fetching useres")
        fetchSuggestFriends();
        fetchmyFriends();
        fetchFriendRequests();
       
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            returnValue = suggestedFriendsList.count;break
        case 1:
            returnValue = friendRequestsList.count;break
        case 2:
            returnValue = myFriendsList.count;break
        default:
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Instantiate a cell
       let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ImageTableViewCell
     
        let user = cell.viewWithTag(2) as! UILabel
        let imageView = cell.viewWithTag(1) as! UIImageView

        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            cell.addAsFriend.isHidden = false
            cell.rejectBtn.isHidden = true
            cell.acceptBtn.isHidden = true
            
            user.text = self.suggestedFriendsList[indexPath.row].fullName
            
            let url = NSURL(string: self.suggestedFriendsList[indexPath.row].profileImage)
            let data = NSData(contentsOf: url! as URL)
            if data != nil {
                imageView.image = UIImage(data: data! as Data)?.resized(withPercentage: 0.1)
            }
            
            cell.uId = self.suggestedFriendsList[indexPath.row].uId
            
            break
        case 1:
           
            cell.rejectBtn.isHidden = false
            cell.acceptBtn.isHidden = false
            cell.addAsFriend.isHidden = true
            
            
            user.text = self.friendRequestsList[indexPath.row].fullName
            
            let url = NSURL(string: self.friendRequestsList[indexPath.row].profileImage)
            let data = NSData(contentsOf: url! as URL)
            if data != nil {
                imageView.image = UIImage(data: data! as Data)?.resized(withPercentage: 0.1)
            }
            
            
            cell.uId = self.friendRequestsList[indexPath.row].uId
            break
        case 2:
            
            cell.addAsFriend.isHidden = true
            cell.rejectBtn.isHidden = true
            cell.acceptBtn.isHidden = true
            user.text = self.myFriendsList[indexPath.row].fullName
            
            let url = NSURL(string: self.myFriendsList[indexPath.row].profileImage)
            let data = NSData(contentsOf: url! as URL)
            if data != nil {
                imageView.image = UIImage(data: data! as Data)?.resized(withPercentage: 0.1)
            }
            
            
            cell.uId = self.myFriendsList[indexPath.row].uId
            
            break
        default:
            break
        }

        return cell
    }
    
    @IBAction func ItemSelected(_ sender: Any) {
        tableView.reloadData()
    }
    

    func fetchSuggestFriends()
    {
        var suggestedFriendProfile = UserProfile()
       
//       self.users.removeAll()
        FIRDatabase.database().reference().child("users").observe(.value, with: { (snapshot) in
            for suggestedfriendSnap in snapshot.children{
                    
                if let suggestedfriend = (suggestedfriendSnap as! FIRDataSnapshot).value as? [String:AnyObject]{
                        
                    suggestedFriendProfile.fullName = suggestedfriend["fullName"] as! String
                    if((suggestedfriend["profileImage"]) != nil){
                        suggestedFriendProfile.profileImage = suggestedfriend["profileImage"] as! String
                    }
                    
                     if((suggestedfriend["uId"]) != nil){
                        suggestedFriendProfile.uId = suggestedfriend["uId"] as! String
                    }
                    self.suggestedFriendsList.append(suggestedFriendProfile)
                }
            }
        })
    }
    
    func fetchFriendRequests() {
        
        var friendRequestProfile = UserProfile()
        
        //self.users.removeAll()
    FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").observe(.value, with:
        {(friendsReqSnapshot) in

             if let friendReq = friendsReqSnapshot.value as? [String:AnyObject]
             {
                for reqFriendId in friendReq
                {
             
                    print("friend number",reqFriendId.key)
                    if(reqFriendId.key != nil)
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
                                self.friendRequestsList.append(friendRequestProfile)
                            }
                        })
                    }
                }
            }
        })
    }
    
    func fetchmyFriends() {
        
        var myFriendProfile = UserProfile()
        
        //self.users.removeAll()
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").observe(.value, with:
            {(mysnapshot) in
                
                if let friend = mysnapshot.value as? [String:AnyObject]
                {
                    for friendid in friend
                    {
                        
                        print("friend number",friendid.key)
                        if(friendid.key != nil)
                        {
                            FIRDatabase.database().reference().child("users").child(friendid.key).observe(.value, with:
                                { (myfriendsnapshot) in
                                    
                                    if let myfriend = myfriendsnapshot.value as? [String:AnyObject]
                                    {
                                        
                                        myFriendProfile.fullName = myfriend["fullName"] as! String
                                        if((myfriend["profileImage"]) != nil){
                                            myFriendProfile.profileImage = myfriend["profileImage"] as! String
                                        }
                                        
                                        if((myfriend["uId"]) != nil){
                                            myFriendProfile.uId = myfriend["uId"] as! String
                                        }
                                        self.myFriendsList.append(myFriendProfile)
                                    }
                            })
                        }
                    }
                }
        })
        
    }

}

extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
