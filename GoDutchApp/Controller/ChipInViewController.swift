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
    
    @IBOutlet weak var titleButton: UILabel!
    @IBOutlet weak var totalAmountTitle: UILabel!
    @IBOutlet weak var totalAmountValue: UILabel!
    @IBOutlet weak var amountCollectedTitle: UILabel!
    @IBOutlet weak var amountCollectedValue: UILabel!
    @IBOutlet weak var chipInTitle: UILabel!
    @IBOutlet weak var tempText: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var amountText: UITextField!
    
    override func viewDidLoad(){
        self.amountText.delegate = self
        
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
            //add new amount to amount collected
            let newData = Firestore.firestore().collection("rooms").document("yxNcGMeCRFxFE53qMI0H")
            //+++++Connecting to firebase+++++
            newData.getDocument(source: .cache){ (document, error) in
                if let document = document{
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Cached document data: \(dataDescription)")
                    let roomDictionary = document.data()
                    let amountHere = roomDictionary!["Amount Collected"] as! String
                    //++++addint all of the information back together +++++++
                    //amountHere -> Int + amount -> back to string!
                    let a:Double? = Double(amountHere) // firstText is UITextField
                    let b:Double? = Double(amount) // secondText is UITextField

                        // check a and b before unwrapping using !
                        
                    var newTotal = a! + b!
                    
                    //updatting the information in firebase
                    newData.updateData(["Amount Collected": ("\(newTotal)") ]){err in
                        if let err = err{
                            print("Error updating document: \(err)")
                        }else{
                            print("Document \(newTotal) updated successfully")
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                    
                }
            }
        }
    }
    
//    func updateAmount() -> String{
//        let amount = amountText.text
//        //firebase info to update the amount needed here
//        //pull the data and then take just the collection amount
//        //from there send it as a string to the saveAction funciton
//        Firestore.firestore().collection("rooms").document("yxNcGMeCRFxFE53qMI0H")
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
        
