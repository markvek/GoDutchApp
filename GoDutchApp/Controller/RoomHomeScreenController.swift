//
//  RoomHomeScreenController.swift
//  GoDutchApp
//
//  Created by Mark on 11/24/21.
//

import Foundation
import UIKit
//import PhotoKit
import MessageUI
import Firebase

class RoomHomeScreenController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate/*, MFMessageComposeViewControllerDelegate*/{
    
    
    
    
    //this is the name of the var that is pulled from another screen
    var roomDoucmentId: String!

    //image picker info
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var totalAmountTitle: UILabel!
    @IBOutlet weak var totalAmountValue: UILabel!
    @IBOutlet weak var amountCollectedTitle: UILabel!
    @IBOutlet weak var amountCollectedValue: UILabel!
    @IBOutlet weak var chipInButton: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var sendTextButton: UIButton!
    
    
    //=======SENDING TEXT MESSAGE========
    //tutorial 1. https://www.youtube.com/watch?v=cWttLcDJfLk
    //Git Hub Link: https://stackoverflow.com/questions/26350220/sending-sms-in-ios-with-swift
    //add a text feild to gather a phone number here
    @IBAction func sendText(_ sender: UIButton) {
        sendTextAction()
    }
    
//    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
//        <#code#>
//    }
    
//    func messageComposeViewController(didFinishWithResult result: MessageComposeResult) {
            //... handle sms screen actions
        //dismissViewControllerAnimated
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//
//    override func viewWillDisappear(animated: Bool) {
//            self.navigationController?.navigationBarHidden = false
//    }
    
    @objc func sendTextAction(){
        if MFMessageComposeViewController.canSendText(){
            let controller = MFMessageComposeViewController()
            controller.body = "Firebase Info"
        }
//        if (MFMessageComposeViewController.canSendText()) {
        
        //=== FETCHING SOME FIREBASE SNACKS ==
//
        var messageText = "rename me"
        let roomRef = Firestore.firestore().collection("rooms").document(roomDoucmentId) //document(ref!.documentID)
        roomRef.getDocument(source: .cache){ (document, error) in
            if let document = document{
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Cached document data: \(dataDescription)")
                //making sure to translate the data into just showing one part
                let roomDictionary = document.data()
                let amountHere = roomDictionary!["Amount"] as! String
                let roomHere = roomDictionary!["Room"] as! String
                let amountCollectedHere = roomDictionary!["Amount Collected"] as! String
                messageText = "The room '\(roomHere)' you are in needs to collect $\(amountHere). You have already collected $\(amountCollectedHere)"
                
                // == FIREBASE FETCHED AND STRING READY FOR SENDING TEXT בתאבין אחי ==
                
                    //UNCOMENT THIS FOR SENDING SMS MESSAGE
                    //UNCOMENT THE LINE 14 CODE
        //            let controller = MFMessageComposeViewController()
        //            controller.body = "Message Body"
        //            let phoneNum = "9498386262"
        //            controller.recipients = [phoneNum] //[phoneNumber.text]
        //            controller.messageComposeDelegate = self
        //            self.present(controller, animated: true, completion: nil)
                    print(messageText)
                    
                
          } else {
            print("Document does not exist in cache")
          }
        }
        
            
            
//        } MAKE SURE TO UNCOMMENT ME TOO!
        
    }
    
    //======END SENDING TEXT MESSAGE=======
    
    //=======Keybaord Kahoot=========
    
    
    @IBAction func phoneNumberDone(_ sender: Any) {
        phoneNumber.resignFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    //=======Keybaord Kahoot End =========
    
    func imagegPickerSet(){
        //Image Picker Busienss
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//        imagePicker.mediaTypes = ["public.image", "public.movie"]
//        imagePicker.sourceType = .photoLibrary
//        //present imagePicker
//        present(imagePicker, animated: true, completion: nil)
    }
    // implement delegate methods
    //
    //check ITP324_PhotoKit.pdf
    
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info:
    [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        // do something interesting here!
            picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker:
        UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    //Image Picker Business closed
    
    @IBAction func shareDidTapped(_ sender: Any) {
    }
    
    @IBAction func chipInDidTapped(_ sender: UIButton) {
        //chipInDidTapped
        self.performSegue(withIdentifier: "chipInSegue", sender: roomDoucmentId)
    }
    
    //prepare for segue here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChipInViewController, let roomDoucmentId = sender as? String{
            vc.roomDoucmentChipIn = roomDoucmentId
        }
    }
    
    override func viewDidLoad() {
        loadTotalData()
        loadCollectedData()
        
        
        //========Additional Keybaord Kahoot ========
        self.phoneNumber.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //========Additional Keybaord Kahoot Done ========

    }
    
    func loadTotalData(){
//        let dataDescription = "01"
        //+++++++FIREBASE TOTAL AMOUNT DATA ONCE+++++++
        //https://firebase.google.com/docs/firestore/query-data/get-data
        let roomRef = Firestore.firestore().collection("rooms").document(roomDoucmentId) //document(ref!.documentID)
        roomRef.getDocument(source: .cache){ (document, error) in
            if let document = document{
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Cached document data: \(dataDescription)")
                //making sure to translate the data into just showing one part
                let roomDictionary = document.data()
                let amountHere = roomDictionary!["Amount"] as! String
                self.totalAmountValue.text = ("\(amountHere)")
          } else {
            print("Document does not exist in cache")
          }
        }
        
        //+++++++FIREBASE LOAD TITLE ONCE+++++++
        //https://firebase.google.com/docs/firestore/query-data/get-data
        let roomName = Firestore.firestore().collection("rooms").document(roomDoucmentId) //document(ref!.documentID)
        roomName.getDocument(source: .cache){ (document, error) in
            if let document = document{
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Cached document data: \(dataDescription)")
                let roomDictionary = document.data()
                let titleHere = roomDictionary!["Room"] as! String
                self.roomTitle.text = ("\(titleHere)")
          } else {
            print("Document does not exist in cache")
          }
        }
        
        
    }
    
    func loadCollectedData(){
        //+++++++FIREBASE LISTEN FOR DATA +++++++
        //https://firebase.google.com/docs/firestore/query-data/listen
        Firestore.firestore().collection("rooms").document(roomDoucmentId)
            .addSnapshotListener { documentSnapshot, error in guard let document = documentSnapshot else{
                print("Error fetching document: \(error!)")
                        return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                print("Current data: \(data)")
                
                let roomDictionary = document.data()
                let amountNow = roomDictionary!["Amount Collected"] as! String
                self.amountCollectedValue.text = ("\(amountNow)")
            }

    }
    
    
    
}

