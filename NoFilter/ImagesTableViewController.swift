//
//  ImagesTableViewController.swift
//  MyImagesTab
//
//  Created by Luis Esquivel on 2017-02-28.
//  Copyright © 2017 luis. All rights reserved.
//

import UIKit
import Firebase

class ImagesTableViewController: UITableViewController {
    
    @IBOutlet weak var imageTableView: UITableView!
    
    var uPostsList = [UserPost]()
    var userCellPosts = UserPost()
    
    var iPostCount: Int = 0
    
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
                    self.uPostsList.append(userPost)
                }
            }
            
            DispatchQueue.main.async {
                self.imageTableView.reloadData()
            }
            
        } , withCancel: nil)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPosts()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return uPostsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imagesCell", for: indexPath) as! ImagesTableViewCell
        
        // Fetches the appropriate image for the data source layout.
        
        if (iPostCount == 0) {
            iPostCount = indexPath.row
        } else {
            iPostCount += 1
        }
        
        if (uPostsList.count > iPostCount) {
            userCellPosts = uPostsList[iPostCount]
            var imgurl = userCellPosts.pathToImage
            var url = NSURL(string: imgurl)
            var data = NSData(contentsOf: url! as URL) // this URL convert into Data
            if data != nil {  //Some time Data value will be nil so we need to validate such things
                cell.image1Cell.image = UIImage(data: data! as Data)
                
            }
            
            iPostCount += 1
            
            if (uPostsList.count > (iPostCount)) {
                userCellPosts = uPostsList[iPostCount]
                imgurl = userCellPosts.pathToImage
                url = NSURL(string: imgurl)
                data = NSData(contentsOf: url! as URL) // this URL convert into Data
                if data != nil {  //Some time Data value will be nil so we need to validate such things
                    cell.image2Cell.image = UIImage(data: data! as Data)
                    
                }
            }
            
            iPostCount += 1
            
            if (uPostsList.count > (iPostCount)) {
                userCellPosts = uPostsList[iPostCount]
                imgurl = userCellPosts.pathToImage
                url = NSURL(string: imgurl)
                data = NSData(contentsOf: url! as URL) // this URL convert into Data
                if data != nil {  //Some time Data value will be nil so we need to validate such things
                    cell.image3Cell.image = UIImage(data: data! as Data)
                    
                }
            }
        }


        

    
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
