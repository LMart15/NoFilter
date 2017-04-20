//
//  HomeCollectionViewController.swift
//  NoFilter
//
//  Created by Lawrence Martin on 2017-04-16.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage
import SVProgressHUD
class HomeCollectionViewController: UICollectionViewController {
    
    var uPostsList = [UserPost]()
    var userCellPosts = UserPost()
    
    var iPostCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SVProgressHUD.show(withStatus: "Loading!!")
        //SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.gradient)
        fetchPosts()
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return uPostsList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! HomeHeaderCollectionReusableView
        
        header.profileImg.layer.cornerRadius = header.profileImg.frame.size.width / 2
        header.profileImg.clipsToBounds = true
        //header.backgroundColor = UIColor.white
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        //print("usersID",userID!)
        let uref = FIRDatabase.database().reference().child("users").child(userID!)
        
        uref.observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let profileImage = value?["profileImage"] as! String
            self.navigationItem.title = value?["fullName"] as? String
            let numFriends = snapshot.childSnapshot(forPath: "Friends/myFriends").childrenCount
            
        
            if let statusTemp = value?["userStatus"] as! String!
            {
                if statusTemp != nil {
                    header.bio_txtview.text = statusTemp
                }
            }
            
            header.numPosts_lbl.text = String (self.uPostsList.count)
            header.numFollowing_lbl.text = String (numFriends)
            let url = NSURL(string: profileImage)
            let data = NSData(contentsOf: url! as URL) // this URL convert into Data
            if data != nil {  //Some time Data value will be nil so we need to validate such things
                header.profileImg.image = UIImage(data: data! as Data)
                header.profileImg.layer.cornerRadius = header.profileImg.frame.width/2.0
                header.profileImg.clipsToBounds = true
            }
            
        })
       
        return header
        
    }
    
    func fetchPosts(){
        let eref = FIRDatabase.database().reference().child("posts")
        var userPost = UserPost()
        
        eref.observe(.childAdded, with: { (snaps) in
            if let dictn = snaps.value as? [String : AnyObject]
            {
                let userID = FIRAuth.auth()?.currentUser?.uid
                if(userID == dictn["uId"] as? String){
                    
                    userPost.author = dictn["displayName"] as! String
                    userPost.likes = String(describing: dictn["likes"])
                    userPost.pathToImage = dictn["pathToImage"] as! String
                    userPost.postId = dictn["postId"] as! String
                    userPost.uId = dictn["uId"] as! String
                    userPost.key = snaps.key
                    userPost.timestamp = dictn["timestamp"] as! String
                    //self.uPostsList.append(userPost)
                    self.uPostsList.insert(userPost, at: 0)
                }
            }
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        } , withCancel: nil)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        cell.frame.size.width = (self.collectionView?.frame.size.width)! / 3
        let placeHolderImage = UIImage(named: "AppIcon")
        
        userCellPosts = uPostsList[indexPath.row]
        var imgurl = userCellPosts.pathToImage
        var url = NSURL(string: imgurl)
        var data = NSData(contentsOf: url! as URL) // this URL convert into Data
        if data != nil {  //Some time Data value will be nil so we need to validate such things
            cell.sd_setShowActivityIndicatorView(true)
            cell.postImg_img.sd_setImage(with: url as URL?, placeholderImage: placeHolderImage)
        }
        
        //cell.backgroundColor = UIColor.black
         //SVProgressHUD.dismiss()
        return cell
    }
    

    
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
