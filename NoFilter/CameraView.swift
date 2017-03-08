//
//  CameraView.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-03-08.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit

class CameraView: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    
    @IBOutlet weak var imageViewer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.camera
        image.allowsEditing=false
        self.present(image, animated: true)
        {
            //
        }

    }

    @IBAction func takePic(_ sender: UIButton) {
        
           }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       imageViewer.image=info[UIImagePickerControllerOriginalImage] as! UIImage;
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postImage(_ sender: UIButton) {
        
        
        
    }
}
