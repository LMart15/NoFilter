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

class RegisterScreenView: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    
    var scrollViewHeight: CGFloat = 0
    var keyboard = CGRect()
    
    let picker = UIImagePickerController()
  //  let userDatabaseRef =
    var userStorage: FIRStorageReference!
    var userRef: FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //get scrollview height of container
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize.height = self.view.frame.height
        scrollViewHeight = scrollView.frame.size.height
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: .UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: .UIKeyboardWillHide , object: nil)
        
        let hideOnTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTap))
        hideOnTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideOnTap)
        
        //Round image
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
        
        let profileOnTap = UITapGestureRecognizer(target: self, action: #selector(selectProfilePicOnTap))
        profileOnTap.numberOfTapsRequired = 1
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(profileOnTap)
  
        
        picker.delegate = self
        let storage = FIRStorage.storage().reference(forURL:"gs://projectreall-35e59.appspot.com")
        userStorage = storage.child("users")
        userRef = FIRDatabase.database().reference()
        
        fullname.delegate = self
        email.delegate = self
        username.delegate = self
        password.delegate = self
        confirmpassword.delegate = self
        phonenumber.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    func hideKeyboardTap(recognizer: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func showKeyboard(notification:NSNotification){
        
        keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!
        
        UIView.animate(withDuration: 0.4) {
            self.scrollView.frame.size.height = self.scrollViewHeight - self.keyboard.height
        }
    }
    
    func hideKeyboard(notification:NSNotification){
        
        UIView.animate(withDuration: 0.4) {
            self.scrollView.frame.size.height = self.view.frame.height
        }
    }
    
    
    @IBAction func AddPhoto(_ sender: Any) {
        selectProfile()
    }
    
    func selectProfilePicOnTap(recognizer: UITapGestureRecognizer){
        
        selectProfile()
        
    }
    
    func selectProfile(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
  /*  @IBAction func done(_ sender: Any) {
        guard fullname.text != "", email.text != "",password.text != "" ,confirmpassword.text != "", phonenumber.text != "", username.text != ""else { return }
        if password.text == confirmpassword.text {
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: {(user,error) in
            
                if let error = error {
                    print(error.localizedDescription)
                }
                if let user = user {
                    let currentTime = Date()
                    let dateFormat = DateFormatter()
                    dateFormat.timeStyle = .medium
                    dateFormat.dateStyle = .medium
                    
                    let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest();
                    changeRequest?.displayName = self.fullname.text
                    changeRequest?.commitChanges(completion: nil)
                    if self.profileImg.image == nil {
                        print("profile image is nill")
                        let userInfo: [String: Any] = ["uId":user.uid,
                                                       "fullName":self.fullname.text,
                                                       "profileImage":"",
                                                       "phoneNumber":self.phonenumber.text,
                                                       "username":self.username.text,
                                                       "timestamp":dateFormat.string(from: currentTime)]
                        
                        self.userRef.child("users").child(user.uid).setValue(userInfo)
                    
                        self.performSegue(withIdentifier: "signupToHome", sender: self)
                    }
                    else {
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
                                
                                print("Photo Url :: \(url.absoluteString)")
                                
                                let userInfo: [String: Any] = ["uId":user.uid,
                                                               "fullName":self.fullname.text,
                                                               "profileImage":url.absoluteString,
                                                               "phoneNumber":self.phonenumber.text,
                                                               "username":self.username.text,
                                                               "timestamp":dateFormat.string(from: currentTime)]
                      
                                self.userRef.child("users").child(user.uid).setValue(userInfo)
                            }
                        })
                        
                    })
                    uploadTask.resume()
                    self.performSegue(withIdentifier: "signupToHome", sender: self)
                    }
                }
            })
        }else {
            print("Password does not match")
        }
        
    }   */
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func signUpBtnAction(_ sender: UIButton) {
        
        guard fullname.text != "", email.text != "",password.text != "" ,confirmpassword.text != "", phonenumber.text != "", username.text != ""else { return }
        if password.text == confirmpassword.text {
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: {(user,error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                if let user = user {
                    let currentTime = Date()
                    let dateFormat = DateFormatter()
                    dateFormat.timeStyle = .medium
                    dateFormat.dateStyle = .medium
                    
                    let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest();
                    changeRequest?.displayName = self.fullname.text
                    changeRequest?.commitChanges(completion: nil)
                    if self.profileImg.image == nil {
                        print("profile image is nill")
                        let userInfo: [String: Any] = ["uId":user.uid,
                                                       "fullName":self.fullname.text,
                                                       "profileImage":"",
                                                       "phoneNumber":self.phonenumber.text,
                                                       "username":self.username.text,
                                                       "timestamp":dateFormat.string(from: currentTime)]
                        
                        self.userRef.child("users").child(user.uid).setValue(userInfo)
                        
                        self.performSegue(withIdentifier: "signupToHome", sender: self)
                    }
                    else {
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
                                    
                                    print("Photo Url :: \(url.absoluteString)")
                                    
                                    let userInfo: [String: Any] = ["uId":user.uid,
                                                                   "fullName":self.fullname.text,
                                                                   "profileImage":url.absoluteString,
                                                                   "phoneNumber":self.phonenumber.text,
                                                                   "username":self.username.text,
                                                                   "timestamp":dateFormat.string(from: currentTime)]
                                    
                                    self.userRef.child("users").child(user.uid).setValue(userInfo)
                                }
                            })
                            
                        })
                        uploadTask.resume()
                        //self.dismiss(animated: true, completion: nil)
                        self.performSegue(withIdentifier: "signupToHome", sender: self)
                    }
                }
            })
        }else {
            print("Password does not match")
        }
        

    }
}
