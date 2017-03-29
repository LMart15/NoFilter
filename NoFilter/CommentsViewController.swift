//
//  CommentsViewController.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-03-29.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class CommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var postId:String!
    @IBOutlet weak var tableContent: UITableView!
    
     var list:[String]=["Good Work!"]
     var ref=FIRDatabase.database().reference()
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var myCommentField: UITextField!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return list.count
    }
    
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=tableView.dequeueReusableCell(withIdentifier: "rows", for: indexPath) as! CommentsViewCell
        let commentViewer = cell.viewWithTag(2) as! UILabel
        
        commentViewer.text=list[indexPath.row]
        
         return cell
    }
    
    @IBAction func commentBtnOperation(_ sender: Any) {
        
        if(myCommentField.text?.isEmpty==false)
        {
            self.list.append(myCommentField.text!)
           
            self.tableContent.reloadData()
            print("from CommentsViewController: \(postId)")
         /*
            var ref=FIRDatabase.database().reference().child("posts").child(self.postId).child("comments").child("textComments")
            ref.updateChildValues([(FIRAuth.auth()?.currentUser)!:myCommentField])
 */
            
        }
        else{
         
        }
        
        
    }    
    
}
