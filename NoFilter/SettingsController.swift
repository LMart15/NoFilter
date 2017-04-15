//
//  SettingsController.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-04-14.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase
class SettingsController: UIViewController {

    
    @IBAction func logoutAction(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
        self.performSegue(withIdentifier: "logOutSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    
}
