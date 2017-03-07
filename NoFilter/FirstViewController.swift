//
//  FirstViewController.swift
//  HomeFeature Tab
//
//  Created by Harpreet singh on 2017-02-28.
//  Copyright © 2017 assignment2. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var myTable: UITableView!
    
    var uProfile = [UserProfile]()
    var uPosts = [UserPost]()
    var userPosts = UserPost()
    var refHandle: UInt!
    var ref: FIRDatabaseReference!
    
    
    
    
    
    var names=["Haapi","gopi","new"]
    
    var images=["best","gh","unn"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        fetchPosts()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return names.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let user=cell.viewWithTag(2) as! UILabel
        user.text=names[indexPath.row]
        let imghs=cell.viewWithTag(3) as! UIImageView
        imghs.image=UIImage(named: images[indexPath.row])
        return cell
    }
    
    
    
    func fetchPosts(){
        let eref = FIRDatabase.database().reference().child("Posts")
        var userPost = UserPost()
        eref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]  {
                print( "snapshot",snapshot.key)
                userPost.key = snapshot.key
                userPost.author = dictionary["author"] as! String
                userPost.likes = dictionary["likes"] as! String
                userPost.pathToImage = dictionary["pathToImage"] as! String
            }
            
            self.uPosts.append(userPost)
            
            DispatchQueue.main.async {
                self.myTable.reloadData()
            }
            
        } , withCancel: nil)
        
    }


}

