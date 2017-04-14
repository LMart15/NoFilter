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
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
