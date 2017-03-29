//
//  CommentsViewController.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-03-29.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit

import FirebaseDatabase

class CommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
     var ref=FIRDatabase.database().reference()
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var myCommentField: UITextField!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return 0
    }
    
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
         return cell
    }
    
    @IBAction func commentBtnOperation(_ sender: Any) {
        
        var comment=myCommentField.text
        ref.child("posts")
        
    }
    
    
}
