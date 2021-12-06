//
//  TableViewController.swift
//  GoDutchApp
//
//  Created by Mark on 12/1/21.
//

import Foundation
import UIKit
import Firebase

//class cellPreviewTableView{
//
//    let room: String
//    let amount: String
//
//    init(room: String, amount: String){
//        self.room = room
//        self.amount = amount
//    }
//}

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    @IBOutlet weak var tableView: UITableViewCell!
    
    //view will apear informaiton here
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        print("data has been reloaded")
        //self.roomList.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. get the data via firebase or a static data set first
        
        //2. configure cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell")!
        cell.textLabel?.text = "Room Name"
        cell.detailTextLabel?.text = "Amount"
        //3. return cell
        return cell
    }
    
    
    
}
