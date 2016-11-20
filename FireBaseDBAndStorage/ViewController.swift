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

class ViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
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
}

