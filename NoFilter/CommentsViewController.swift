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
    var commentorInfo = UserProfile()
            //audio file url
   
    //var myAudioplayer:AVAudioPlayer!
    var myAudioplayer:AVPlayer! // Changed
    
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
        let audioPlay = cell.playBtn as! UIButton
        
        userCellComments=uCommentsList[indexPath.row]
        audioPlay.tag = indexPath.row // Added
        
        
        
        //Fetch Commentor info - Image and Name from Database
        
        let commenterName = FIRDatabase.database().reference().child("users").child(userCellComments.commentedBy)
        
        commenterName.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]  {
                //print( "usersnapshot",snapshot.children.allObjects)
                self.commentorInfo.key = snapshot.key
                self.commentorInfo.fullName = dictionary["fullName"] as! String
                self.commentorInfo.profileImage = dictionary["profileImage"] as! String
//                print("fullName",self.commentorInfo.fullName)
                
                
                // Add Commentor Image and Name to comments
                
                userName.text = self.commentorInfo.fullName
                
                let url = NSURL(string: self.commentorInfo.profileImage)
                let data = NSData(contentsOf: url! as URL) // this URL convert into Data
                if data != nil {  //Some time Data value will be nil so we need to validate such things
                    userImage.setImage(UIImage(data: data! as Data), for: [])
                }

                
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
            audioPlay.isEnabled=true
            audioPlay.isHidden=false
            commentViewer.isEnabled=false
            commentViewer.isHidden=true
            url=userCellComments.comment
            //print("comment is>>>>\(userCellComments.comment)")
            //let ll = "http://gaana.com/song/hamen-tumse-pyar-kitna-2"
            //audioPlay.addTarget(self, action: #selector(self.playAudio(sender:)), for: UIControlEvents.touchUpInside)
            
            
            
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
            print("post ID ",self.pid , " values post ID", values)
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
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        
        
        let url = uCommentsList[sender.tag].comment
        
        FIRStorage.storage().reference(forURL: url as! String).metadata { (metadata, error) in
            if error != nil{
                print("error getting metadata")
            } else {
                let downloadUrl = metadata?.downloadURL()
                print(downloadUrl!)
                
                if downloadUrl != nil{
                    
                    self.myAudioplayer = AVPlayer(url: downloadUrl!)
                    self.myAudioplayer.play()
                    
                    
                    print("downloadUrl obtained and set")
                }
            }
        }
        
        
    }


    
}


