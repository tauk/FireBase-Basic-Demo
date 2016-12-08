//
//  ViewController.swift
//  FireBaseDBAndStorage
//
//  Created by Tauseef Kamal on 11/17/16.
//  Copyright © 2016 Tauseef Kamal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //create a new record
    @IBAction func doSave(_ sender: Any) {
        let name = tfName.text
        let email = tfEmail.text
        
        //get a reference to the the database
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        //save the data from the form as a new child node by using setValue()
        ref.child("users").child(name!).setValue(["username": name, "email":email])
        
        print("Save done!")
        
        // Points to the root reference
        let storageRef = FIRStorage.storage().reference(forURL: "gs://appsdb-5dfe3.appspot.com/")
        
        // Points to "images"
        //let imagesRef = storageRef.child("images")
        
        // Points to "images/space.jpg"
        
        
        // Data in memory
        //let data: NSData
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.3)
        
        //let compressedJPGImage = UIImage(data: imageData!)
        
        // Create a reference to the file you want to upload
        let userImageRef = storageRef.child("images/\(name!).jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        _ = userImageRef.put(imageData!, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
                print(error!.localizedDescription)
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL
                let url = metadata?.downloadURL()?.absoluteString
                print(downloadURL)
                
                ref.child("users").child(name!).child("imageurl").setValue(url)
            }
        }
    }

    //update only email
    @IBAction func doUpdate(_ sender: Any) {
        let name = tfName.text
        let email = tfEmail.text
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        //update the child of the child node using updateChildValues()
        ref.child("users").child(name!).updateChildValues(["email":email!])
        
        print("update done!")
    }

    //delete by name
    @IBAction func doDelete(_ sender: Any) {
        let name = tfName.text
        //let email = tfEmail.text
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()
        
        ref.child("users").child(name!).removeValue()
        
        print("delete done!")
    }
    
    //delegate function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    //take photo
    @IBAction func takePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertView(title: "Error!",
                                    message: "No camera on this device!",
                                    delegate: nil,
                                    cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    //select photo from the gallery
    @IBAction func selectPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertView(title: "Error!",
                                    message: "Photo library not accessible",
                                    delegate: nil,
                                    cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
}

