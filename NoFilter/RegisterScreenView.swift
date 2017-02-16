//
//  RegisterScreenView.swift
//  NoFilter
//
//  Created by Basil on 2017-02-15.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase

class RegisterScreenView: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    
    let picker = UIImagePickerController()
    
    @IBAction func AddPhoto(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    @IBAction func done(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profileImg.layer.cornerRadius = 25;
        profileImg.layer.masksToBounds = true
        picker.delegate = self
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = (info[UIImagePickerControllerEditedImage] as? UIImage)  {
            self.profileImg.image = image
            
        }else {
            print("Something went wrong")
        }
        
    }

}
