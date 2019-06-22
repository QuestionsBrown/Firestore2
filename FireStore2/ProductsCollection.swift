//
//  ProductsCollection.swift
//  FireStore2
//
//  Created by Concetta Turner on 11/6/18.
//  Copyright © 2018 Concetta Turner. All rights reserved.
//

import UIKit

class ProductsCollection: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCell
        
        return cell
    }
    
    


    

}
