//
//  ShowAllUsersViewController.swift
//  FireBaseDBAndStorage
//
//  Created by Tauseef Kamal on 11/19/16.
//  Copyright © 2016 Tauseef Kamal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import CoreGraphics


class ShowAllUsersViewController: UIViewController {

    @IBOutlet weak var usersDataLabel: UILabel!
    
    var dbReference: FIRDatabaseReference!
    var usersReference : FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        //reference to database
        self.dbReference = FIRDatabase.database().reference()
        
        //reference to users in database
        self.usersReference = dbReference.child("users")//.queryOrdered(byChild: "username")
        
        let xVal = 20
        var yVal = 70
        
        let imageXVal = 240;
        var imageYVal = 70;
        
        //data comes into a snapshot object
        self.usersReference.observe(.childAdded, with: { (snapshot) in
            
            //var usersSnapshotArray = [FIRDataSnapshot]()
            
            //from the snapshot get the entry as key-value (KV)pair
            //use a swift native Dictionary object to hold the KV pair
            let snapshotValue = snapshot.value as! Dictionary<String, String>
        
            //use the keys to get the values
            let userName = snapshotValue["username"]
            let email = snapshotValue["email"]
            
            var nameEmailLabel : UILabel
            nameEmailLabel = UILabel(frame: CGRect(x:xVal, y:yVal, width:200, height:120))
            nameEmailLabel.text = "\(userName!)  \(email!)"
            self.view.addSubview(nameEmailLabel)
            
            //if there is an imageurl then show the image
            if let imageurl = snapshotValue["imageurl"] {
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
                        //add a image view dynamically into the view
                        var imageView : UIImageView
                        imageView  = UIImageView(frame:CGRect(x:imageXVal, y:imageYVal, width:100, height:100));
                        imageView.image = compressedImage
                        self.view.addSubview(imageView)
                        
                        imageYVal = imageYVal + 120
                    }
                }
                
            }
            
            //xVal = xVal + 30
            yVal = yVal + 100
            
            //data.append("\n \(userName!) \(email!)")
            //self.usersDataLabel.text = data
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
