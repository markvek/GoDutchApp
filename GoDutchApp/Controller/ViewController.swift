//
//  ViewController.swift
//  GoDutch
//
//  Created by Mark on 11/17/21.
//

import UIKit
import Firebase
//import GoogleSignIn



class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //this is to check if a user is logged in
//    override func viewWillAppear(_ animated: Bool){
//        super.viewWillAppear(true)
//        if Auth.auth().currentUser != nil {
//          print("User is signed in.")
//          // ...
//        } else {
//            print("no user is signed in.")
//          // ...
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
    
        //click background too remove keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //+++++++++Notification +++++++++
        let notification = UILocalNotification()
        notification.alertTitle = "hey"
        notification.alertBody = "whats going on"
        notification.fireDate = Date(timeIntervalSinceNow: 10)
        //what does remove as observer mean? or do
        
        UIApplication.shared.scheduleLocalNotification(notification)
        //+++++++++Notification  +++++++++
        
        
        //+++++++++FIREBASE TUTORIAL CODE +++++++++
//      UIApplication.shared.scheduledLocalNotifications(notification)
//        let userCollection = Firestore.firestore().collection("users")

        //WIRTE DATA TO FIREBASE
//        let testReference = userCollection.document("test")
        //set Data is destructive and removes all prev changes to that document (in firebase)
        //to make sure everything is ok add paramenter: merge: true
//        testReference.setData(["name": "test","age": 0], merge: true){ err in
//            if let err = err{
//                print(err.localizedDescription)
//            }else{
//                print("We wrote data to firebase")
//            }
//        }
        
        //ADDDOCUMENT here to put in more information
//        Firestore.firestore().collection("users").addDocument(data: ["name" : "Test", "grade" : "A"], completion:nil)
        //DELETE document informaiton
//        Firestore.firestore().collection("user").document("1").delete()
        //READ DATA ONCE
//        Firebase.firestore().collection("users").document("test").getDocument{ snap, err in
//            let data = snap?.data()
//            let documentID = snap?.documentID()
//            print("getDocument - document id \(documentID) data \(data)")
//        }
//        //READDATAMULTIPLETIMES
//        Firebase.firestore().collection("users").document("test").addSnapshotListener{ snap, err in
//            let data = snap?.data()
//            let documentID = snap?.documentID()
//            print("addSnapshotListener - document id \(documentID) data \(data)")
//        }
        //+++++++++FIREBASE TUTORIAL CODE +++++++++
        
        
    }
    
    //=====Keyboard Functionaluty ==========
    //https://programmingwithswift.com/move-to-next-text-field-with-swift/
    //when done or return button is clicked
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        //emailTextField.resignFirstResponder()
        //passwordTextField.becomeFirstResponder()
        return true
    }
    //change to calling next text field
    private func switchBasedNextTextField(_ textField: UITextField){
        switch textField{
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            //call signup button tap
            signUpAction()
        default:
            self.emailTextField.resignFirstResponder()
        }
    }
    
    @IBAction func emailFieldDoneEditing(_ sender: UITextField) {
        emailTextField.resignFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //=====Keyboard Functionaluty End ======
    
    
    //=======Sign Up Buttin Tapped ==========
    @IBAction func signUpDidTapped(_ sender: Any) {
        signUpAction()
//        let email = emailTextField.text!
//        let password = passwordTextField.text!
    }
    
    @objc func signUpAction(){
        let email = emailTextField.text!
        let password = passwordTextField.text!
        //making sure all info is validated
        if(email != "" || password != ""){
            print("calling")
            print("Open Main Page")
            //call diff page to open
            
//            +++++++++FIREBASE ADD Data+++++++
            var ref: DocumentReference? = nil
            ref = Firestore.firestore().collection("users").addDocument(data: [
                "email": email,
                "password": password
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
//            +++++++++FIREBASE END +++++++
                //if statnemtn here to stop code
            performSegue(withIdentifier: "signUpSegue", sender: nil)
        }else{
            print("error") //
        }
    }
    //=======Sign Up Buttin Tapped End ==========
    
    struct Person{
        let name: String
    }

}


