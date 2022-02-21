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
import SwiftUI

class RoomHomeScreenController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate{
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
        //Displaying the message screen with animation.
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //this is the name of the var that is pulled from another screen
    var roomData: room!

    //image picker info
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var totalAmountValue: UILabel!
    @IBOutlet weak var amountCollectedValue: UILabel!
    @IBOutlet weak var chipInButton: UIButton! // goes to chipInSegue
//    @IBOutlet weak var phoneNumber: UITextField! //replace this with a proper apple share functionality
    @IBOutlet weak var sendTextButton: UIButton!
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var paymentTableView: UITableView!
    
    override func viewDidLoad() {
        loadTotalData()
        loadCollectedData()
        
        //Table View Kahoot
        paymentTableView.delegate = self
        paymentTableView.dataSource = self
        
        //========Additional Keybaord Kahoot ========
//        self.phoneNumber.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //========Additional Keybaord Kahoot Done ========

    }
    
    //===Segue Excitemnt===
    
    @IBAction func chipInTapped(_ sender: Any) {
        chipInAction()
    }
    
    @objc func chipInAction(){
        self.performSegue(withIdentifier: "chipInSegue", sender: chipInButton.self)
    }
    //===End of Segue Excitemnt===
    
    //=======Table View Kahoot=======
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    //SECTION HEADERS DO NOT WORK
    func tableView(in tableView: UITableView!, tableView section: Int) -> String!{
        if (section == 0){
            let nameOne = "Pending Payments"
            return nameOne
        }
        if (section == 1){
            let nameTwo = "Recorded Payments"
            return nameTwo
        }
        return "Test"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Mark is a Cowboy"
        cell.detailTextLabel?.text = "Ori is a Spy"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let cell =
        print("Cell Selected")
        performSegue(withIdentifier: "paymentDrilldownSegue", sender: paymentTableView)
        print("Table Clicked")
    }
    
    //need to add clicking functionality

    
    //=======Table View Kahoot End=====
    
    //=====Imagination Image Creation======
    
    @IBAction func selectImageDidTappee(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        //checks if camera is avalible to take a photo
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let originalImage = info[.originalImage] as! UIImage
        roomImage.image = originalImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //=====Imagination Image Creation======
    
    //=======SENDING TEXT MESSAGE========
    //tutorial 1. https://www.youtube.com/watch?v=cWttLcDJfLk
    //Git Hub Link: https://stackoverflow.com/questions/26350220/sending-sms-in-ios-with-swift
    //add a text feild to gather a phone number here
    @IBAction func sendText(_ sender: UIButton) {
        sendTextAction()
    }
    

    func sendTextAction(){
        if MFMessageComposeViewController.canSendText(){
            let controller = MFMessageComposeViewController()
            controller.body = "Firebase Info"
        }
//        if (MFMessageComposeViewController.canSendText()) {
        
        //=== FETCHING SOME FIREBASE SNACKS ==
//
        
        
        var messageText = "rename me"
        
        messageText = "The room '\(roomData.room)' you are in needs to collect $\(roomData.amount). You have already collected $\(roomData.amountCollected)"
        
        
//        if (MFMessageComposeViewController.canSendText()) {
//            let controller = MFMessageComposeViewController()
//            controller.body = messageText
////            let phoneNum = (phoneNumber.text != nil) ? phoneNumber.text! : ""
//            controller.recipients = [phoneNum] //Here goes whom you wants to send the message
//            controller.messageComposeDelegate = self
//            self.present(controller, animated: true, completion: nil)
//        }
        //This is just for testing purpose as when you run in the simulator, you cannot send the message.
//        else{
//            print("Cannot send the message")
//        }

        /*
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
        }*/
        
            
            
//        } MAKE SURE TO UNCOMMENT ME TOO!
        
    }
    
    //    @IBAction func phoneNumberDone(_ sender: Any) {
    //        phoneNumber.resignFirstResponder()
    //    }
    
    //======END SENDING TEXT MESSAGE=======
    
    //=======Keybaord Kahoot=========
    
    

    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //=======Keybaord Kahoot End =========

    @IBAction func chipInDidTapped(_ sender: UIButton) {
        //chipInDidTapped
        print("Room ID: \(roomData)")
        self.performSegue(withIdentifier: "chipInSegue", sender: roomData)

    }
    
    //prepare for segue here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChipInViewController, let roomData = sender as? room{
            vc.roomData = roomData
        }
    }
    

    
    func loadTotalData(){
//        let dataDescription = "01"
        //+++++++FIREBASE TOTAL AMOUNT DATA ONCE+++++++
        //https://firebase.google.com/docs/firestore/query-data/get-data
        
        self.totalAmountValue.text = ("\(roomData.amount)")
        /*
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
        }*/
        
        //+++++++FIREBASE LOAD TITLE ONCE+++++++
        //https://firebase.google.com/docs/firestore/query-data/get-data
        
        self.roomTitle.text = ("\(roomData.room)")
        /*
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
        */
        
    }
    
    func loadCollectedData(){
        //+++++++FIREBASE LISTEN FOR DATA +++++++
        //https://firebase.google.com/docs/firestore/query-data/listen
        self.amountCollectedValue.text = ("\(roomData.amountCollected)")
        /*
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
            */
    }
    
    
    
}

