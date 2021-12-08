//
//  HomePageController.swift
//  GoDutchApp
//
//  Created by Mark on 11/24/21.
//

import Foundation
import UIKit
import Firebase

class HomePageController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var documentTemp: String = ""
    
    var rooms = [room]()
    
    @IBOutlet weak var createNewRoom: UIButton!
    @IBOutlet weak var goToRoom: UIButton!
    @IBOutlet weak var roomList: UITableView!
    
    
    //view will apear informaiton here
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        print("data has been reloaded")
        self.roomList.reloadData()
    }
    
    
    
    //=======table view kahoot======
    //view will apear informaiton here
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. get the data via firebase or a static data set first
        
//        init(style: .subtitle ,reuseIdentifier: nil)
        //2. configure cell
        let cell = roomList.dequeueReusableCell(withIdentifier: "MainCell")!
//        UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = "Room Name"
        cell.detailTextLabel?.text = "Amount"
        
        print("CELL: ")
        print(cell)
        //3. return cell
        return cell
    }


    //=======table view kahoot end ======

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("table view")
        title = "Table View Title"
        
        roomList.register(UITableViewCell.self, forCellReuseIdentifier: "Test")
        //++++++FIREBASE GET DATA FROM FIRESTORE AND PLACE INTO ARRAY+++
        Firestore.firestore().collection("rooms").getDocuments { querySnapshot, Error in
            for document in querySnapshot!.documents {
                let roomDictionary = document.data()
                let roomName = roomDictionary["Room"] as! String
                let roomAmount = roomDictionary["Amount"] as! String
                let roomAmountCollected = roomDictionary["Amount Collected"] as! String
                
                let room = room(amount: roomAmount, amountCollected: roomAmountCollected, room: roomName)
                self.rooms.append(room)
            }
        }
        
        
    }
    
    //this code here should be deleted and then replicated in the table view
    @IBAction func openDidTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "openRoomSegue", sender: documentTemp)
    }
    
    @IBAction func createNewRoomDidTapped(_ sender: Any) {
    
    }
    
    //== this function is called after the segue is called up -- and help pass the doc id (ref!.documentID) to the next page==
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var documentTemp = "yxNcGMeCRFxFE53qMI0H"
        if let vc = segue.destination as? RoomHomeScreenController, let documentId = sender as? String{
            vc.roomDoucmentId = documentTemp
        }
    }
    
}

