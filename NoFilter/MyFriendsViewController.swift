//
//  MyFriendsViewController.swift
//  NoFilter
//
//  Created by CSI Admin on 2017-04-19.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD


class MyFriendsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var myFriendsList = [UserProfile]()
    var myFriendsCell = UserProfile()
    @IBOutlet weak var myFriendsTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.myFriendsTableView.reloadData()
        fetchmyFriends();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.myFriendsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return myFriendsList.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell=tableView.dequeueReusableCell(withIdentifier: "MCell", for: indexPath) as! MyFriendsTableViewCell
        

            let user = cell.profileName as! UILabel
            let imageView = cell.profileImage as! UIButton
        
            myFriendsCell = myFriendsList[indexPath.row]
        
            user.text = myFriendsCell.fullName
            
            let url = NSURL(string: myFriendsCell.profileImage)
            let data = NSData(contentsOf: url! as URL)
            if data != nil {
                //                imageView.image = UIImage(data: data! as Data)?.resized(withPercentage: 0.1)
                imageView.setImage(UIImage(data: data! as Data), for: UIControlState.normal)
                imageView.layer.cornerRadius = imageView.frame.width/2.0
                imageView.layer.masksToBounds = true
            }
        
            cell.uId = myFriendsCell.uId
            return cell
    }
    

    
    
    func fetchmyFriends() {

        var myFriendProfile = UserProfile()
         let friendsref = FIRDatabase.database().reference().child("users")
        
        friendsref.child((FIRAuth.auth()?.currentUser?.uid)!).child("Friends").child("myFriends").observe(.value, with:
            {(mysnapshot) in
                 self.myFriendsList.removeAll()
                if let friend = mysnapshot.value as? [String:AnyObject]
                {
                    for friendid in friend
                    {
                        friendsref.child(friendid.key).observe(.value, with:
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
                                    print("My Friends",myFriendProfile.uId )
                                    self.myFriendsList.append(myFriendProfile)
                                }
                        })
                    }
                }
                DispatchQueue.main.async
                    {
                        self.myFriendsTableView.reloadData()
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
