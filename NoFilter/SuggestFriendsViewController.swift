//
//  SuggestFriendsViewController.swift
//  NoFilter
//
//  Created by CSI Admin on 2017-04-19.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD


class SuggestFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var suggestedFriendsList = [UserProfile]()
    var suggestedFriendsCell = UserProfile()
    var suggestedFriends = Set<String>()
    
    
    @IBOutlet weak var suggestFriendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            fetchSuggestFriends();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        //self.suggestFriendsTableView.reloadData()
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return suggestedFriendsList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "SCell", for: indexPath) as! SuggestFriendsTableViewCell
        
        let user = cell.profileName as! UILabel
        let imageView = cell.profileImage as! UIButton
        
        suggestedFriendsCell = suggestedFriendsList[indexPath.row]
        
        user.text = suggestedFriendsCell.fullName
        let url = NSURL(string: suggestedFriendsCell.profileImage)
    
        let data = NSData(contentsOf: url! as URL)
        
            if data != nil
            {
                //imageView.image = UIImage(data: data! as Data)?.resized(withPercentage: 0.1)
                imageView.setImage(UIImage(data: data! as Data), for: UIControlState.normal)
                imageView.layer.cornerRadius = imageView.frame.width/2.0
                imageView.layer.masksToBounds = true
            }
        
            cell.uId = suggestedFriendsCell.uId
        
            return cell
    }

    
    
    func fetchSuggestFriends()
    {
         let friendsref = FIRDatabase.database().reference().child("users")
        
        var suggestedFriendProfile = UserProfile()
        
        self.suggestedFriends.insert((FIRAuth.auth()?.currentUser?.uid)!)
        
        friendsref.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("myFriends").observe(.value, with:
            {(mysnapshot) in
                
                if let friend = mysnapshot.value as? [String:AnyObject]
                {
                    for friendid in friend
                    {
                        self.suggestedFriends.insert(friendid.key)
                    }
                }
        })
        
        friendsref.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("friendRequests").observe(.value, with:
            {(mysnapshot) in
                
                if let friend = mysnapshot.value as? [String:AnyObject]
                {
                    for friendid in friend
                    {
                        self.suggestedFriends.insert(friendid.key)
    
                    }
                }
            })
        
        friendsref.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("pendingRequests").observe(.value, with:
            {(mysnapshot) in
                
                if let friend = mysnapshot.value as? [String:AnyObject]
                {
                    for friendid in friend
                    {
                        self.suggestedFriends.insert(friendid.key)
                    }
                }
            })
        friendsref.observe(.value, with: { (snapshot) in
    
            self.suggestedFriendsList.removeAll()
            for suggestedfriendSnap in snapshot.children{
                
                if(self.suggestedFriends.contains((suggestedfriendSnap as! FIRDataSnapshot).key))
                {
                    // print("already friends",(suggestedfriendSnap as! FIRDataSnapshot).key)
                }
                else{
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
            }
            DispatchQueue.main.async {
                self.suggestFriendsTableView.reloadData()
            }
            
        } , withCancel: nil)
            
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

