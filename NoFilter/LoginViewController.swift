//
//  LoginViewController.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-03-28.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase 

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username_label: UITextField!
    
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
        
        
        username_label.delegate = self
        password.delegate = self
        if FIRAuth.auth()?.currentUser != nil {
            print(FIRAuth.auth()?.currentUser?.email)
            self.performSegue(withIdentifier: "directSign", sender: nil)
        }
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
