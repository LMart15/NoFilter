//
//  TESTUSERPASSViewController.swift
//  NoFilter
//
//  Created by Lawrence Martin on 2017-04-19.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit

class TESTUSERPASSViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func passUserIDAction_btn(_ sender: UIButton) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ProfilePage") as! HomeCollectionViewController
        myVC.passedInUserID = "7YA8V2w5G5fpBDV5zYZAF4mI7Ua2"
        self.navigationController?.pushViewController(myVC, animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
