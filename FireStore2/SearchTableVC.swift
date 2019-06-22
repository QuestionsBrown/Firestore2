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



class SearchTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moreTableView: UITableView!
    
    @IBOutlet weak var catagoryTableView: UITableView!
    
    @IBOutlet weak var search: UISearchBar!
    
    
    private var mcCafeStruct = [myMcafeeStruct]()
    private var moreStrcut = [myDonutPage1Struct]()
    
    
    lazy var mcafeCollection = Firestore.firestore().collection("Mcafes")
    lazy var donutsCollection = Firestore.firestore().collection("donuts")
    
    lazy var moreeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 142.0/255.0, green: 68.0/255.0, blue: 173.0/255.0, alpha: 1.0)
        return tableView
    }()
    
    lazy var moreeTableView2: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 180.0/255.0, green: 90/255.0, blue: 173.0/255.0, alpha: 1.0)
        
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let tableView = UISearchBar()
//        tableView.backgroundColor = UIColor(red: 180.0/255.0, green: 90/255.0, blue: 173.0/255.0, alpha: 1.0)
        tableView.frame = CGRect(x: 0, y: 89, width: 375, height: 60)
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
       
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        moreeTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        moreeTableView.register(TableViewCelly.self, forCellReuseIdentifier: "YessirCell")
        moreeTableView.dataSource = self
        moreeTableView.delegate = self
        
        self.moreeTableView.rowHeight = UITableView.automaticDimension
        self.moreeTableView.estimatedRowHeight = 250
        
        
        view.backgroundColor = UIColor.red
        
        view.addSubview(moreeTableView)
        
        moreeTableView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        moreeTableView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        moreeTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        moreeTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(searchBar)
        
        searchBar.widthAnchor.constraint(equalToConstant: 375).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        moreeTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        


//    getmcCafeCatagoryJson()
    getDonuts()
}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case moreeTableView:
            return moreStrcut.count
            
//        case moreeTableView2:
//            return mcCafeStruct.count
            
        default:
            return 1
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "YessirCell")
//        cell.textLabel!.text = moreStrcut[indexPath.row].name
//
//        let imagesArray = moreStrcut[indexPath.row].imageRef
//        let storageBih = Storage.storage().reference().child("images").child(imagesArray)
//        cell.imageView?.sd_setImage(with: storageBih)
        
        
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "YessirCell", for: indexPath) as? TableViewCelly else { return UITableViewCell() }
        
//        return cell
        
     
//
//
        switch tableView {

        case moreeTableView:
        cell2.catagoryName.text = moreStrcut[indexPath.row].name


        let imagesArray = moreStrcut[indexPath.row].imageRef
        let storageBih = Storage.storage().reference().child("images").child(imagesArray)
        cell2.moreImages.sd_setImage(with: storageBih)
        
        
        cell2.layoutSubviews()

        return cell2


//        case moreeTableView2:
//        cell.catagoryName.text = mcCafeStruct[indexPath.row].catagoryName
//
//        let imagesArray = mcCafeStruct[indexPath.row].imageRef
//        let storageBih = Storage.storage().reference().child("coffeImages").child(imagesArray)
//        cell.catagoryImage.sd_setImage(with: storageBih)

//        return cell

        default:

        return TableViewCell.init()
        
    }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 150
    }


    func getmcCafeCatagoryJson() {
        mcafeCollection.getDocuments { (snapshot, _) in
            
            let myCatagoryNames: [myMcafeeStruct] = try! snapshot!.decoded()
            print(myCatagoryNames)
            self.mcCafeStruct = myCatagoryNames
            //stop animating
            //            myUsers.forEach({ print($0) })
            
            DispatchQueue.main.async {
                self.moreeTableView.reloadData()
                //need optional check
            }
        }
    }
    
    func getDonuts() {
        donutsCollection.getDocuments { (snapshot, _) in
            
            let myMore: [myDonutPage1Struct] = try! snapshot!.decoded()
            print(myMore)
            self.moreStrcut = myMore
            //stop animating
            //            myUsers.forEach({ print($0) })
            
            DispatchQueue.main.async {
                self.moreeTableView.reloadData()
                //need optional check
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        switch segue.identifier {
        case "catagorySeg":
            
            guard let indexPath2 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
            guard let detailViewController = segue.destination as? DetailVC else { return }
            
        
            let imagesArray = mcCafeStruct[indexPath2.row].imageRef
        
            //catagoryImages
            var homeDonutImages: StorageReference {
                return Storage.storage().reference().child("coffeImages").child(imagesArray)
            }
            detailViewController.storageReff = homeDonutImages

        case .none:
            print("ayyye")
        case .some(_):
            print("ayyyye")
            
            }
        }
    }




