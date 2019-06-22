//
//  ViewController.swift
//  FireStore2
//
//  Created by Concetta Turner on 11/5/18.
//  Copyright © 2018 Concetta Turner. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class tableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
@IBOutlet weak var tableView: UITableView!
    
    
//var tableViewNigga = TableViewCell()
    
private var donuts = [myDonut]()
lazy var usersCollection = Firestore.firestore().collection("donuts")

override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    getDonutJson()
//    tableViewLoadImages()
}
    
//    func tableViewLoadImages() {
//        tableViewNigga.downloadImages()
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donuts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YessirCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        cell.donutLabel.text = donuts[indexPath.row].name
        cell.descriptionLabel.text = donuts[indexPath.row].description
        cell.priceLabel.text = "$" + donuts[indexPath.row].price
        
        cell.contentView.backgroundColor = UIColor.white
        //        cell.backgroundColor = UIColor.darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 210
    }

    func getDonutJson() {
        usersCollection.getDocuments { (snapshot, _) in
            
            let myUsers: [myDonut] = try! snapshot!.decoded()
            print(myUsers)
            self.donuts = myUsers
            //            myUsers.forEach({ print($0) })
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }

}


