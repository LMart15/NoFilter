//
//  ImagesTableViewController.swift
//  MyImagesTab
//
//  Created by Luis Esquivel on 2017-02-28.
//  Copyright © 2017 luis. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {
    
    
    var images = [Images]()
    
    func loadSampleImages() {
        let photo1 = UIImage(named: "sample1")!
        let photo2 = UIImage(named: "sample2")!
        let photo3 = UIImage(named: "sample3")!
        let photo4 = UIImage(named: "sample4")!
        let photo5 = UIImage(named: "sample5")!
        let photo6 = UIImage(named: "sample6")!
        
        //let photo1 = UIImage(named: "meal1")!
        
        let image1 = Images(photo1: photo1, photo2: photo2, photo3: photo3)!
        let image2 = Images(photo1: photo4, photo2: photo5, photo3: photo6)!
        
        images += [image1, image2]
        
    }
    /*
    func fetchPosts(){
        let eref = FIRDatabase.database().reference().child("posts")
        var userPost = UserPost()
        
        eref.observe(.childAdded, with: { (snaps) in
            if let dictn = snaps.value as? [String : AnyObject]
            {
                let userID = FIRAuth.auth()?.currentUser?.uid
                if(userID == dictn["uId"] as? String){
                    //print("postdictvalue",dict.values,"count",dict.count)
                    print( "snapKey",snaps.key, "hello")
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
                self.postTable.reloadData()
            }
            
        } , withCancel: nil)
        
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleImages()

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
        return images.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imagesCell", for: indexPath) as! ImagesTableViewCell
        
        // Fetches the appropriate image for the data source layout.
        let image = images[indexPath.row]
        
        cell.image1Cell.image = image.photo1
        cell.image2Cell.image = image.photo2
        cell.image3Cell.image = image.photo3
    
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
