//
//  RegisterScreenView.swift
//  NoFilter
//
//  Created by Basil on 2017-02-15.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterScreenView: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    
    let picker = UIImagePickerController()
  //  let userDatabaseRef =
    var userStorage: FIRStorageReference!
    var userRef: FIRDatabaseReference!
    @IBAction func AddPhoto(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    @IBAction func done(_ sender: Any) {
        guard fullname.text != "", email.text != "",password.text != "" ,confirmpassword.text != "", phonenumber.text != "", username.text != ""else { return }
        if password.text == confirmpassword.text {
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: {(user,error) in
            
                if let error = error {
                    print(error.localizedDescription)
                }
                if let user = user {
                    let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest();
                    changeRequest?.displayName = self.fullname.text
                    changeRequest?.commitChanges(completion: nil)
                    
                    let imageRef = self.userStorage.child("\(user.uid).jpg")
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
                                let currentTime = Date()
                                
                                let dateFormat = DateFormatter()
                                dateFormat.timeStyle = .medium
                                dateFormat.dateStyle = .medium
                                
                                let userInfo: [String: Any] = ["uId":user.uid,
                                                               "fullName":self.fullname.text,
                                                               "profileImage":url.absoluteString,
                                                               "phoneNumber":self.phonenumber.text,
                                                               "username":self.username.text,
                                                               "timestamp":dateFormat.string(from: currentTime)]
                                /*
                                let userInfo: [String: Any] = ["uId":user.uid,
                                                               "fullName":self.fullname.text,
                                        
                                                               "phoneNumber":self.phonenumber.text,
                                                               "username":self.username.text]   */
                                self.userRef.child("users").child(self.username.text!.lowercased()).setValue(userInfo)
                            }
                        })
                        
                    })
                    uploadTask.resume()
                 /*   let userInfo: [String: Any] = ["uId":user.uid,
                                                   "fullName":self.fullname.text,
                                                   
                                                   "phoneNumber":self.phonenumber.text,
                                                   "username":self.username.text]
                    self.userRef.child("users").child(self.username.text!.lowercased()).setValue(userInfo)*/

                }
            })
        }else {
            print("Password does not match")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // profileImg.layer.cornerRadius = 25;
       // profileImg.layer.masksToBounds = true
        picker.delegate = self
        let storage = FIRStorage.storage().reference(forURL:"gs://projectreall-35e59.appspot.com")
        userStorage = storage.child("users")
        userRef = FIRDatabase.database().reference()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }*/

}
