//
//  FloatingBtnViewController.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-04-04.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import KCFloatingActionButton
class FloatingBtnViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let fab=KCFloatingActionButton()
        // fab.buttonImage = UIImage(named: "ff")
               fab.paddingX=50
        fab.paddingY=50
       // fab.isHidden=true
        
        fab.addItem("Send Friend Request", icon: UIImage(named: "friendRequest") )
        fab.addItem("Send Friend Request", icon: UIImage(named: "friendRequest")!, handler: { item in
            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            fab.close()
        })
        self.view.addSubview(fab)
       
    }
 
    
   
}
