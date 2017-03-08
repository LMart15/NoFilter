//
//  AudioCommentsView.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-03-07.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit

class AudioCommentsView: UIViewController {

    
    @IBOutlet weak var commentField: UITextField!
    
    @IBOutlet weak var comtBtn: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func commentsButton(_ sender: UIButton) {
        
        
         dismiss(animated: true, completion: nil)
        
    }
  
}
