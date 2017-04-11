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

    var users = [UserProfile]()
    //var userProfile = UserProfile()
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("fetching useres")
        fetchUsers();
        // Do any additional setup after loading the view.
    }
    
    let myFriendDemoString:[String] = ["A","B","C"]
    let suggentedFriendsString:[String] = ["1","2","3"]
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
//            returnValue = myFriendDemoString.count;break
            returnValue = users.count;break
        case 1:
            returnValue = suggentedFriendsString.count;break
        default:
            break
        }
        return returnValue
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
   //     let element = elements[indexPath.row]
        
        // Instantiate a cell
       let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ImageTableViewCell
     
        let user = cell.viewWithTag(2) as! UILabel
        let imageView = cell.viewWithTag(1) as! UIImageView
        let url = NSURL(string: self.users[indexPath.row].profileImage)
        let data = NSData(contentsOf: url! as URL)
        if data != nil {
            imageView.image = UIImage(data: data! as Data)
        }

        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            //user.text = myFriendDemoString[indexPath.row]
            user.text = self.users[indexPath.row].fullName
             cell.addAsFriend.isHidden = false
             cell.uId = self.users[indexPath.row].uId
          //  print("From FriendsView \(self.users[indexPath.row].uId)")
            break
        case 1:
            user.text = suggentedFriendsString[indexPath.row]
            cell.addAsFriend.isHidden = true
            break
        default:
            break
        }

        return cell
    }
    
    @IBAction func ItemSelected(_ sender: Any) {
        tableView.reloadData()
    }
    

    func fetchUsers() {
        var userProfile = UserProfile()
        let ref = FIRDatabase.database().reference()
        self.users.removeAll()
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: {
            snapshot in
          /*  if  let users = snapshot.value as? [String:Any] {
                userProfile.fullName = users["fullName"] as! String
                print(userProfile.fullName)
                self.users.append(userProfile)
            }*/
            if snapshot.value is NSNull {
                
            }else {
            let snapDic = snapshot.value as? NSDictionary
            for child in snapDic! {
             let childDic = child.value as? NSDictionary
             userProfile.fullName = childDic?["fullName"] as! String
             userProfile.profileImage = childDic?["profileImage"] as! String
             userProfile.uId = childDic?["uId"] as! String
             self.users.append(userProfile)
                
            }
                
            }
        });
        
        
    }
    
    func fectFriends() {
        
    }
   

}

