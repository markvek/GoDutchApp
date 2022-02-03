//
//  ChipInViewController.swift
//  GoDutchApp
//
//  Created by Mark on 11/24/21.
//
import Foundation
import UIKit
import Firebase

class ChipInViewController: UIViewController, UITextFieldDelegate{
    
    var roomData: room!
    // print(roomDoucmentChipIn)
    
    @IBOutlet weak var titleButton: UILabel!
    @IBOutlet weak var totalAmountTitle: UILabel!
    @IBOutlet weak var totalAmountValue: UILabel! //total amount
    @IBOutlet weak var amountCollectedTitle: UILabel!
    @IBOutlet weak var amountCollectedValue: UILabel! //amount collected
    @IBOutlet weak var chipInTitle: UILabel!
    @IBOutlet weak var tempText: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var amountText: UITextField!
    
    override func viewDidLoad(){
        self.amountText.delegate = self
        loadTotalData()
        //dismiss keyboard if you tap on background
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //=======Keyboard Shenanigns====
    //when done or return button is clicked
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveAction()
        //emailTextField.resignFirstResponder()
        //passwordTextField.becomeFirstResponder()
        return true
    }
    
    
    @IBAction func amountDoneEditing(_ sender: UITextField) {
        amountText.resignFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //========No more Keyboard======
    
    
    //========Firebase Load Data here ======
    func loadTotalData(){
//        let dataDescription = "01"
        //+++++++FIREBASE TOTAL AMOUNT DATA ONCE+++++++
        //https://firebase.google.com/docs/firestore/query-data/get-data
        //title informaiton
        self.titleButton.text = (roomData.room)
        
        //amount informaiton
        let amountHere = roomData.amount
        self.totalAmountValue.text = ("\(amountHere)")
    
        
        self.amountCollectedValue.text = ("\(roomData.amountCollected)")

    }
    //========Firebase Load Data here ======
    
    //========save button tapped========
    @IBAction func saveDidTapped(_ sender: UIButton) {
        
        saveAction()
        //save and add to the log updating the room info
        //return bacck to room main home screen
    }
    //========save button actions========
    @objc func saveAction(){
        print("ChipIn Save Action Called")
        let amount = amountText.text!
        
        if(amount != ""){
            
            //+++++Connecting to firebase+++++
//            newData.getDocument(source: .cache){ (document, error) in
//                if let document = document{
//                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                    print("Cached document data: \(dataDescription)")
//                    let roomDictionary = document.data()
//                    let amountHere = roomData.amount
                    //++++addint all of the information back together +++++++
                    //amountHere -> Int + amount -> back to string!
                    let a:Double? = Double(roomData.amountCollected) // firstText is UITextField
                    let b:Double? = Double(amount) // secondText is UITextField
                        // check a and b before unwrapping using !
                        
                    var newTotal = a! + b!
                    //add new amount to amount collected
                    //db.collection("cities").document("BJ").setData([ "capital": true ], merge: true)
                    
            Firestore.firestore().collection("rooms").document(roomData.docId).setData(["Amount Collected": String(newTotal)], merge: true){err in
                        if let err = err{
                            print("Error updating document: \(err)")
                        }else{
                            print("Document \(newTotal) updated successfully")
//                            self.dismiss(animated: true, completion: nil)
                            self.navigationController?.popViewController(animated: true)
                        }
                    
                    //updatting the information in firebase
                    //newData.updateData(["Amount Collected": ("\(newTotal)") ]){err in
//                        if let err = err{
//                            print("Error updating document: \(err)")
//                        }else{
//                            print("Document \(newTotal) updated successfully")
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
                    
                    
//                }
//                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
//    func updateAmount() -> String{
//        let amount = amountText.text
//        //firebase info to update the amount needed here
//        //pull the data and then take just the collection amount
//        //from there send it as a string to the saveAction funciton
//        Firestore.firestore().collection("rooms").document(roomDoucmentChipIn)
//            .addSnapshotListener { documentSnapshot, error in guard let document = documentSnapshot else{
//                print("Error fetching document: \(error!)")
//                        return
//                }
//                guard let data = document.data() else {
//                    print("Document data was empty.")
//                    return
//                }
//                print("Current data: \(data)")
//            }
//        let data = "20"
//        var dataInt = Int(data)
//
////        dataInt = dataInt + Int(amount)
//
//        let dataIntString = ("\(dataInt)")
//        return dataIntString
//    }
}
