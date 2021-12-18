//
//  CreateNewRoomController.swift
//  GoDutchApp
//
//  Created by Mark on 11/25/21.
//

import Foundation
import UIKit
import Firebase

class CreateNewRoom: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var roomNameText: UITextField!
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        self.roomNameText.delegate = self
        self.amountText.delegate = self
        
        //dismiss keyboard if you tap on background
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    //=======Keyboard Shenanigns====
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
        case self.roomNameText:
            self.amountText.becomeFirstResponder()
        case self.amountText:
            //call signup button tap
            saveAction()
        default:
            self.roomNameText.resignFirstResponder()
        }
    }
    
    @IBAction func roomNameDoneEditing(_ sender: UITextField) {
        roomNameText.resignFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //========No more Keyboard======
    
    //========save button tapped========
    @IBAction func saveDidTapped(_ sender: Any) {
        saveAction()
    }
    
    //========save button actions========
    @objc func saveAction(){
        
        // 1
        let roomName = roomNameText.text
        let amount = amountText.text
        
        // 2
        print("saveDidClicked")
        
        //3
        if (roomName != "" || amount != ""){
            
            // 4
            var ref: DocumentReference? = nil
            ref = Firestore.firestore().collection("rooms").addDocument(data: [
                    "Room": roomName!,
                    "Amount": amount!,
                    "Amount Collected": "0"
                    //add user names here too
            ]) { err in
                //this code here is called only after firrebase returns with information
                // 6
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    let roomData: room = room(amount: amount ?? "", amountCollected: "0", room: roomName ?? "Default", docId: ref!.documentID)
                    self.performSegue(withIdentifier: "saveSegue", sender: roomData)
                }
            }
                
                
            //5
        }
    }
    
    //== this function is called after the segue is called up -- and help pass the doc id (ref!.documentID) to the next page==
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RoomHomeScreenController, let roomData = sender as? room{
            vc.roomData = roomData
        }
    }
    
}
