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
import AVFoundation                                 // Import for playing Audio files
class CommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var url:String!
    var postId:String!
    public var pid:String!
    var uCommentsList = [UserComments]()
    var userCellComments = UserComments()
           //audio file url
   
    var myAudioplayer:AVAudioPlayer!
    
    @IBOutlet weak var tableContent: UITableView!
    
    var ref=FIRDatabase.database().reference()
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var myCommentField: UITextField!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    var postRef = FIRDatabase.database().reference().child("posts")
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComments()
        
        
    }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return uCommentsList.count
    }
    
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=tableView.dequeueReusableCell(withIdentifier: "rows", for: indexPath) as! CommentsViewCell
        let userName = cell.viewWithTag(1) as! UILabel
        let commentViewer = cell.viewWithTag(2) as! UILabel
        let userImage = cell.viewWithTag(3) as! UIButton
        let audioPlay = cell.viewWithTag(4) as! UIButton
        
        userCellComments=uCommentsList[indexPath.row]
        
        let userQueryRef = FIRDatabase.database().reference().child("users").queryEqual(toValue: userCellComments.commentedBy)
        
        userQueryRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for snap in snapshot.children {
                let userSnap = snap as! FIRDataSnapshot
                let uid = userSnap.key //the uid of each user
                let userDict = userSnap.value as! [String:AnyObject]
                let username = userDict["fullName"] as! String
                let userImage = userDict["profileImage"] as! String

                print("key = \(uid) and timestamp = \(username)")
            } 
        })
        
       
        if(userCellComments.type=="text")
        {
            
            audioPlay.isEnabled=false
             audioPlay.isHidden=true
            commentViewer.isEnabled=true
            commentViewer.isHidden=false
            commentViewer.text = userCellComments.comment as! String?
        }
        else if(userCellComments.type=="audio")
        {
            commentViewer.isEnabled=false
            commentViewer.isHidden=true
             audioPlay.isEnabled=true
             audioPlay.isHidden=false
            url=userCellComments.comment
            print("comment is>>>>\(userCellComments.comment)")
           // let ll = "http://gaana.com/song/hamen-tumse-pyar-kitna-2"
                      audioPlay.addTarget(self, action: #selector(self.playAudio(sender:)), for: UIControlEvents.touchUpInside)
        }
        
         return cell
    }
    
    @IBAction func commentBtnOperation(_ sender: Any) {
        
        if(myCommentField.text?.isEmpty==false)
        {
            let currentTime = Date()
            let dateFormat = DateFormatter()
            dateFormat.timeStyle = .medium
            dateFormat.dateStyle = .medium
            
            let values: [String : Any] = ["comment": myCommentField.text!,"timestamp":dateFormat.string(from: currentTime),"commentedBy":FIRAuth.auth()?.currentUser?.uid,"type":"text"]
           
            
            self.postRef.child(self.pid).child("comments").childByAutoId().updateChildValues(values)
            //self.list.append(myCommentField.text!)
            //self.tableContent.reloadData()
        }
        else{
          
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func fetchComments(){
        let eref = FIRDatabase.database().reference().child("posts").child(self.pid).child("comments")
        var userComment = UserComments()
        print(self.pid, "snapspid")
        eref.observe(.childAdded, with: { (snaps) in
            if let dictn = snaps.value as? [String : AnyObject]
            {
                    print(snaps.key, "key of snaps")
                    userComment.comment = (dictn["comment"] as! String)
                    userComment.commentedBy = dictn["commentedBy"] as! String
                    userComment.type = dictn["type"] as! String
                   
                    userComment.timestamp = dictn["timestamp"] as! String
                    self.uCommentsList.append(userComment)
            }
            
            DispatchQueue.main.async {
                self.tableContent.reloadData()
            }
            
        } , withCancel: nil)
        
    }

    
    func playAudio(sender: UIButton)
    {
       if let audiourl = URL(string: url)
       {
        do{
             print(url)
           try AVAudioSession.sharedInstance().setActive(true)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            
            try myAudioplayer=AVAudioPlayer(contentsOf: audiourl )
            myAudioplayer.prepareToPlay()
            myAudioplayer.play()
            print("working")
        }catch{
            print("Not working")
          }
        }
        //
    }
    
}


