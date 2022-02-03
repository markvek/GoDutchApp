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
    
    var rooms: [room] = []
    
    @IBOutlet weak var addRoom: UIBarButtonItem!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var roomList: UITableView!
    
    
    //view will apear informaiton here
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        print("data has been reloaded")
        self.roomList.reloadData()
    }
    
    //===preping data for tableview===
    func appendData(){
        //let ref = Firestore.firestore().collection("rooms").document(ref!.documentID)
//        for i in room{
//            //append code
//            getDocuments(source: Firestore.firestore().collection("rooms"), completion: nil)
//        }
    }
    
    
    //===data for tableview is preped===
    
    
    //=======table view kahoot======
    //view will apear informaiton here
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. get the data via firebase or a static data set first
        
//        init(style: .subtitle ,reuseIdentifier: nil)
        //2. configure cell
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
//        let cell = roomList.dequeueReusableCell(withIdentifier: "MainCell")!
//        UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let currentRoom = rooms[indexPath.row]
        cell.textLabel?.text = currentRoom.room //room.room//"Room Name"
        cell.detailTextLabel?.text = currentRoom.amount //room.amount //"Amount"
//        var myImage: UIImage = GoDutch
//        cell.imageView?.image = myImage
        
        print("CELL: ")
        print(cell)
        //3. return cell
        return cell
    }
    
    //clicking functionality
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        documentTemp = room.documentID
        tableView.deselectRow(at: indexPath, animated: true)
        let currentRoom = rooms[indexPath.row]
        performSegue(withIdentifier: "tableViewSegue", sender: currentRoom)
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
                let roomId = document.documentID
                
                
                let room = room(amount: roomAmount, amountCollected: roomAmountCollected, room: roomName, docId: roomId)
                self.rooms.append(room)
            }
            self.roomList.reloadData()
        }
        
        
        
    }
    
    @IBAction func addRoomDidTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "createNewRoomNav", sender: documentTemp)
    }
    
    
    @IBAction func signOutDidTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //this code here should be deleted and then replicated in the table view
    
    
    //== this function is called after the segue is called up -- and help pass the doc id (ref!.documentID) to the next page==
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let vc = segue.destination as? RoomHomeScreenController, let roomData = sender as? room{
            vc.roomData = roomData
        }
    }
    
}

