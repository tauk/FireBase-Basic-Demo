//
//  AllUsersTableViewController.swift
//  FireBaseDBAndStorage
//
//  Created by Tauseef Kamal on 12/3/16.
//  Copyright © 2016 Tauseef Kamal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class AllUsersTableViewController: UITableViewController {
    
    var dbReference: FIRDatabaseReference!
    var usersReference : FIRDatabaseReference!
    
    var userNames = [String]()
    var emails = [String]()
    var imageURLs = [String]()
    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //reference to database
        self.dbReference = FIRDatabase.database().reference()
        
        //reference to users in database
        self.usersReference = dbReference.child("users")//.queryOrdered(byChild: "username")
        
        
        //data comes into a snapshot object
        self.usersReference.observe(.childAdded, with: { (snapshot) in
            
            //var usersSnapshotArray = [FIRDataSnapshot]()
            
            //from the snapshot get the entry as key-value (KV)pair
            //use a swift native Dictionary object to hold the KV pair
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            //use the keys to get the values
            let userName = snapshotValue["username"]! as String
            let email = snapshotValue["email"]! as String
            let imageURL = snapshotValue["imageurl"]! as String
            
            self.userNames.append(userName)
            self.emails.append(email)
            self.imageURLs.append(imageURL)
            
            self.tableView.reloadData()
        })
        
        print("reloading data....")
        tableView.reloadData()
        print("data reloaded....")

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
        return userNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserViewCell", for: indexPath) as! AllUsersTableViewCell
        
        let row = indexPath.row
        cell.userNameLabel.text = userNames[row]
        cell.userNameEmail.text = emails[row]
        //cell.userImageView.image = images[row]
        
        let imageurl = imageURLs[row]
        // Points to the root reference
        let storageRef = FIRStorage.storage()
        
        let imageRef = storageRef.reference(forURL: imageurl)
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.data(withMaxSize: 1 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                print("Error downloading images!")
            } else {
                
                let downloadedImage: UIImage! = UIImage(data: data!)
                
                let compressedImageData = UIImageJPEGRepresentation(downloadedImage, 0.2)
                
                let compressedImage = UIImage(data : compressedImageData!)
                cell.userImageView.image = compressedImage
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
