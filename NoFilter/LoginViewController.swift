//
//  LoginViewController.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-03-28.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
class LoginViewController: UIViewController,FBSDKLoginButtonDelegate,UITextFieldDelegate {

    @IBOutlet weak var username_label: UITextField!
    
    @IBOutlet weak var fbLoginBtn: FBSDKLoginButton!
    @IBOutlet weak var password: UITextField!
    @IBAction func signIn(_ sender: Any) {
        guard username_label.text != "", password.text != "" else {
            return
        }
        FIRAuth.auth()?.signIn(withEmail: username_label.text!, password: password.text!, completion: {(user,error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let user = user {
                //segue to Main Viewcontroller
                //    let vc = UIStoryboard(name:"Main",bundle)
                print("Login Success")
                self.performSegue(withIdentifier: "directSign", sender: nil)
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.navigationController?.navigationBar.isHidden = true;
        // Do any additional setup after loading the view.
        
         fbLoginBtn.delegate=self
        username_label.delegate = self
        password.delegate = self
        if FIRAuth.auth()?.currentUser != nil {
            print(FIRAuth.auth()?.currentUser?.email)
            self.performSegue(withIdentifier: "directSign", sender: nil)
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error != nil){
            print(error.localizedDescription)
            return
        }
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential, completion: {  (user,error) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
           // self.getFBUserData()
            print("User logged In with fb...")
            
            //fffffbbbbbb
         
            
            
        })
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    @IBAction func fbLoginBtnAction(_ sender: Any) {
        print("errors>>>>")
      
        
    }
    
    func getFBUserData(){
        
        print("errors>>>>")
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //  self.dict = result as! [String : AnyObject]
                    print("result>>>>>>>>\(result!)")
                    //print(self.dict)
                }
                else{
                    print("errors>>>>")
                }
            })
        }
    }

    //
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        try! FIRAuth.auth()!.signOut()
        print("user logged out!!")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
      func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
   

}
