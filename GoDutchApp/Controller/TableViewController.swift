//
//  TableViewController.swift
//  GoDutchApp
//
//  Created by Mark on 12/1/21.
//

import Foundation
import UIKit
import Firebase

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
            
    //        let room =
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell")!
    //        cell.textLabel?.text = room.room
    //        cell.detailTextLabel?.text = room.amount
//            let cell = dequeueReusableCell(withIdentifier: "Test", for: indexPath)
            cell.textLabel?.text = "Room Name"
            cell.detailTextLabel?.text = "$ Amount"
//
            return cell
    }
    
    
    
}
