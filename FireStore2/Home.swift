//
//  Home.swift
//  FireStore2
//
//  Created by Concetta Turner on 11/6/18.
//  Copyright © 2018 Concetta Turner. All rights reserved.
//

import UIKit

class Home: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let row = indexPath.row
        
        if row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell") as! CatagoryCell
            
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            
            return cell
        }
        
    
    }
    

    

}
