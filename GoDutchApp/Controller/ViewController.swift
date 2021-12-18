//
//  ViewController.swift
//  GoDutch
//
//  Created by Mark on 11/17/21.
//

import UIKit
import Firebase
import GoogleSignIn



class ViewController: UIViewController, UITextFieldDelegate {
//com.googleusercontent.apps.567351449167-v50kre2tmikae3f5921cjpim0hv006p0
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    
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
        //+++++++++Notification+++++++++
        
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
//            dismissKeyboard()
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
    
    
    //=======Sign Up Buttin Tapped GOOGLE SIGN UP==========
    //https://firebase.google.com/docs/auth/ios/google-signin
    //"com.googleusercontent.apps.567351449167-v50kre2tmikae3f5921cjpim0hv006p0"
    //GOOGLE SIGN IN ATTEMPT 2
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    
    @IBAction func signUpDidTapped(_ sender: Any) {
//        signUpAction()
      
        //ATTEMPT 1 ON GETTING GOOGLE SIGN IN TO WORK
//        let url = URL(string: "com.googleusercontent.apps.567351449167-v50kre2tmikae3f5921cjpim0hv006p0")
        
//        UIApplication.shared.open(url!){(result)} in
//        if result {
        
            guard let clinetID = FirebaseApp.app()?.options.clientID else {return}

            //create the google sign in configuation objkect
            let config = GIDConfiguration(clientID: clinetID)
            
            GIDSignIn.sharedInstance.signIn(with: config, presenting: self){[unowned self] user, error in
                if let error = error{
                    return
                }

                guard
                    let authentication = user?.authentication,
                    let idToken = authentication.idToken
                else {
                    return

                }

                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
                performSegue(withIdentifier: "signUpSegue", sender: nil)
//                Auth.auth().signIn(with: credential){authResult, error in
//                    if let error = error{
//                        print(error.localizedDescription)
//                    }else if authResult != nil {
//                        performSegue(withIdentifier: "signUpSegue", sender: nil)
//                    }
//                }
//            }
        }
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
            //performSegue(withIdentifier: "signUpSegue", sender: nil)
        }else{
            print("error") //
        }
    }
    //=======Sign Up Buttin Tapped End ==========
    
    struct Person{
        let name: String
    }

}


