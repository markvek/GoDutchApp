//
//  RoomHomeScreenController.swift
//  GoDutchApp
//
//  Created by Mark on 11/24/21.
//

import Foundation
import UIKit

import Firebase

class RoomHomeScreenController: UIViewController{
    
    //this is the name of the var that is pulled from another screen
    var roomDoucmentId: String!

    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var totalAmountTitle: UILabel!
    @IBOutlet weak var totalAmountValue: UILabel!
    @IBOutlet weak var amountCollectedTitle: UILabel!
    @IBOutlet weak var amountCollectedValue: UILabel!
    @IBOutlet weak var logTitle: UILabel!
    @IBOutlet weak var logValue: UILabel!
    @IBOutlet weak var chipInButton: UIButton!
    
    
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
