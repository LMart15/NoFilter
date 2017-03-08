//
//  ViewController.swift
//  NoFilter
//
//  Created by Lawrence Martin on 2017-02-08.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {

    @IBOutlet weak var username_label: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func google(_ sender: Any) {
        
    }
    @IBAction func facebookSign(_ sender: Any) {
    }
    
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
    
    @IBAction func signUp(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

