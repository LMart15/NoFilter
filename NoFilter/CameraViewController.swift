//
//  CameraViewController.swift
//  NoFilter
//
//  Created by Basil on 2017-03-15.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import DKCamera
import Firebase
import FirebaseDatabase

class CameraViewController: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
        self.performSegue(withIdentifier: "logOutSegue", sender: self)
    }
    
    
    
    func takePhotoOnLoad(){
        let camera = DKCamera()
        
        camera.didCancel = { () in
            print("didCancel")
            
            self.backToHome()
        }
        
        
        camera.didFinishCapturingImage = {(image: UIImage) in
            print("didFinishCapturingImage")
            let data  = UIImageJPEGRepresentation(image, 0.5)
            let user = FIRAuth.auth()?.currentUser!
            let key = self.postDatabaseRef.childByAutoId().key
            
            
            let dateString = NSDate()
            let imageName: String = "\(FIRAuth.auth()?.currentUser?.uid)-\(dateString)"
            
            let uploadImageRef = self.postStorageRef!.child((user?.uid)!).child("\(key).jpg")
            
            let Timestamp = NSDate().timeIntervalSince1970*1000  //Timestamp
            
            let uploadTask = uploadImageRef.put(data!,metadata:nil, completion: { (metadata,err) in
                if err != nil {
                    print(err?.localizedDescription)
                    
                }
                uploadImageRef.downloadURL(completion: {(url,er) in
                    if er != nil{
                        print(er?.localizedDescription)
                    }
                    if let url = url {
                        //For getting current time
                        
                        print("Photo Url :: \(url.absoluteString)")
                        
                        let postInfo: [String: Any] = ["uId":user!.uid,
                                                       "pathToImage":url.absoluteString,
                                                       "likes":0,
                                                       "displayName":user?.displayName,
                                                       "postId":key,
                                                       "timestamp":String(Timestamp)]
                        let postFeed = ["\(key)" : postInfo]
                        self.postDatabaseRef.updateChildValues(postFeed)
                    }
                })
                
            })
            uploadTask.resume()
            self.backToHome()
        }
        self.present(camera, animated: false, completion: nil)
    }
    
    var postStorageRef: FIRStorageReference!
    var postDatabaseRef: FIRDatabaseReference!
    @IBAction func takePhoto(_ sender: Any) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storage = FIRStorage.storage().reference(forURL:"gs://projectreall-35e59.appspot.com");
        postStorageRef = storage.child("posts")
        let dataRef = FIRDatabase.database().reference()
        postDatabaseRef = dataRef.child("posts")
        // Do any additional setup after loading the view.
        takePhotoOnLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        takePhotoOnLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToHome(){
        self.dismiss(animated: false, completion: nil)
        tabBarController?.selectedIndex = 0
    }
    

   }
