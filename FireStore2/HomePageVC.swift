//
//  HomePageVC.swift
//  FireStore2
//
//  Created by Concetta Turner on 5/10/19.
//  Copyright © 2019 Concetta Turner. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet weak var homePageLargePicture: UIImageView!
    
    @IBOutlet weak var homepageTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? QTableViewCelly else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? QTableViewCelly else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
