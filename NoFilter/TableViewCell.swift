//
//  TableViewCell.swift
//  HomeFeature Tab
//
//  Created by harpreet singh on 2017-02-28.
//  Copyright © 2017 assignment2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
struct keyvar {
    static var key = ""
}

class TableViewCell: UITableViewCell {

    
    
    //likes
    var county=0
    @IBOutlet weak var unlikeB: UIButton!
    @IBOutlet weak var likeB: UIButton!
   
    @IBOutlet weak var showLike: UILabel!
    
    //postid
    var postId:String!
     public var id:String!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var textComment: UIButton!
    @IBOutlet weak var voiceButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

    @IBAction func likeButtonChange(_ sender: UIButton) {
      //  toggle(button: sender, onImage: #imageLiteral(resourceName: "likep"), ofImage: #imageLiteral(resourceName: "likeb"))
        
        let ref=FIRDatabase.database().reference()
        let keyToPost = ref.child("posts").childByAutoId().key
    }
    
    
   
    //Like Button functionality
    @IBAction func onClickLikeB(_ sender: UIButton) {
      
        county=0
       
       sender.transform = CGAffineTransform(rotationAngle: 45)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 9, options: .allowUserInteraction, animations:
            {
                sender.transform=CGAffineTransform.identity
                 sender.isHidden=true
        }, completion: nil)
        sender.isHidden=true
        sender.isEnabled=false
        unlikeB.isEnabled=true
        unlikeB.isHidden=false
        showLike.text=String(county)+" likes"
        let update=["likes":county]
          let ref : FIRDatabaseReference!
        ref = FIRDatabase.database().reference()

        ref.child("posts").child(self.postId).updateChildValues(update)
        print(self.postId)
           id=postId
       
    }
    //Unlike Button functionality
    @IBAction func onClickUnlikeB(_ sender: UIButton) {
        county=1
        sender.isHidden=true
        sender.isEnabled=false
        likeB.isEnabled=true
        likeB.isHidden=false
        showLike.text=String(county)+" likes"
      //  let ref=FIRDatabase.database().reference().child("posts").postId.
        
        let ref : FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        print("value\(county)")
        //  ref.child("posts").child("postId").updateChildValues(["likes": county])
        //let number:[AnyHashable : Any]=county
        let update=["likes":county]
       
    ref.child("posts").child(self.postId).updateChildValues(update)
         print("test\(self.postId)")
       
        //get likes
        
       
        
    }
    
   
    
    @IBAction func performCommentsButtonAction(_ sender: UIButton) {
        ///sender.ti = self.postId
        print(self.postId)
    
    }
    
    
    
    
    
}
