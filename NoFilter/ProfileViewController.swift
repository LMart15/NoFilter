//
//  ProfileViewController.swift
//  NoFilter
//
//  Created by Basil on 2017-04-12.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var userRef:FIRDatabaseReference!
    var userStorage:FIRStorageReference!
    var userProfile = UserProfile()
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var status: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
  
    let picker = UIImagePickerController()
    
    @IBAction func AddPhoto(_ sender: UIButton) {
        selectProfile()
    }
    @IBAction func Done(_ sender: Any) {
        guard fullName.text != "",userName.text != "", phoneNumber.text != "" else {
            return
        }
        let currentTime = Date()
        let dateFormat = DateFormatter()
        dateFormat.timeStyle = .medium
        dateFormat.dateStyle = .medium
        
        let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest();
        changeRequest?.displayName = self.fullName.text
        changeRequest?.commitChanges(completion: nil)
        if self.profileImg.image == nil {
            print("profile image is nill")
            let userInfo: [String: Any] = ["uId":FIRAuth.auth()?.currentUser?.uid,
                                           "fullName":self.fullName.text,
                                           "username":self.userName.text,
                                           "profileImage":"",
                                           "phoneNumber":self.phoneNumber.text,
                                           "userStatus":self.status.text,
                                           "timestamp":dateFormat.string(from: currentTime)]
            
            self.userRef.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(userInfo)
            
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
        else {
            let imageRef = self.userStorage.child("\(FIRAuth.auth()?.currentUser?.uid).jpg")
            let data = UIImageJPEGRepresentation(self.profileImg.image!, 0.5)
            let uploadTask = imageRef.put(data!,metadata:nil, completion: { (metadata,err) in
                if err != nil {
                    print(err?.localizedDescription)
                    
                }
                imageRef.downloadURL(completion: {(url,er) in
                    if er != nil{
                        print(er?.localizedDescription)
                    }
                    if let url = url {
                        //For getting current time
                        
                        print("Photo Url :: \(url.absoluteString)")
                        let userInfo: [String: Any] = ["uId":FIRAuth.auth()?.currentUser?.uid,
                                                       "fullName":self.fullName.text,
                                                       "profileImage":url.absoluteString,
                                                       "phoneNumber":self.phoneNumber.text,
                                                       "userStatus":self.status.text,
                                                       "timestamp":dateFormat.string(from: currentTime)]
                        
                        
                        self.userRef.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(userInfo)
                    }
                })
                
            })
            uploadTask.resume()
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picker.delegate = self 
        let storage = FIRStorage.storage().reference(forURL:"gs://projectreall-35e59.appspot.com")
        userStorage = storage.child("users")
        userRef = FIRDatabase.database().reference()
        
        fetchUser() 
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectProfile(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = (info[UIImagePickerControllerOriginalImage] as? UIImage) {
            profileImg.image = image
        }
            
        else if let image = (info[UIImagePickerControllerOriginalImage] as? UIImage)  {
            //self.profileImg.contentMode = .scaleAspectFit
            
            self.profileImg.image = image
            
        }
        else {
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
        
        
    }
    func fetchUser(){
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        //print("usersID",userID!)
        let uref = userRef.child("users").child(userID!)
        
        uref.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject]  {
                //print( "usersnapshot",snapshot.children.allObjects)
                self.userProfile.key = snapshot.key
                self.userProfile.fullName = dictionary["fullName"] as! String
                self.userProfile.profileImage = dictionary["profileImage"] as! String
                self.userProfile.username = dictionary["username"] as! String
                self.userProfile.phoneNumber = dictionary["phoneNumber"] as! String
                //print("fullName",self.userProfile.fullName)
                if let statusTemp = dictionary["userStatus"] as! String!
                {
                    if statusTemp != nil {
                        self.userProfile.status = statusTemp
                        //                    print(statusTemp)
                    }
                }
                self.fullName.text = self.userProfile.fullName
                self.status.text = self.userProfile.status
                self.userName.text = self.userProfile.username
                self.phoneNumber.text = self.userProfile.phoneNumber
                let url = NSURL(string: self.userProfile.profileImage)
                let data = NSData(contentsOf: url! as URL) // this URL convert into Data
                if data != nil {  //Some time Data value will be nil so we need to validate such things
                    self.profileImg.image = UIImage(data: data! as Data)
                    self.profileImg.layer.cornerRadius = self.profileImg.frame.width/2.0
                    self.profileImg.layer.masksToBounds = true
                }
                
                
            }
                
            else{
                //fetch latest post from permanent friend's profile
            }
            
            DispatchQueue.main.async {
            }
            
        } , withCancel: nil)
        
    }


}
