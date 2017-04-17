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

class ProfileViewController: UIViewController {

     let databaseRef = FIRDatabase.database().reference()
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var status: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
  
    @IBAction func AddPhoto(_ sender: UIButton) {
        
    }
    @IBAction func Done(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
