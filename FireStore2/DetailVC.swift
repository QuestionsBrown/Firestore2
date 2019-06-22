//
//  DetailViewController.swift
//  FireStore2
//
//  Created by Concetta Turner on 3/29/19.
//  Copyright © 2019 Concetta Turner. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage
import SDWebImage
import FirebaseUI
import ARKit
import SceneKit

extension DetailVC {
    
    enum ViewControllerSegue: String {
        typealias RawValue = String
        case coffeSeg
        case donutSegue
    }
}

protocol SegueDestination
{
    func prepareAsDestination( segue: UIStoryboardSegue, sender: Any?)
}

extension DetailVC: UICollectionViewDelegateFlowLayout {
    
    //
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: collectionView.bounds.width, height: 50)
    //    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 30), height: CGFloat(100))
        
        //            return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 50), height: CGFloat(100))
    }
    
    
}

//MUST FIX
//HAVE MULTPLE FOR EACH CATAGORY
class DetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getMcafeDocumentNames()
        view.backgroundColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topLbll.text = name
        middleLbll.text =  descriptionYo
        setTitleImg(storageRef: storageReff ?? sugarShackLogo)
    }
    
//    var completionHandler:((UIView) -> String)?

    
    func setTitleImg(storageRef: StorageReference) {
        
        topImage.sd_setImage(with: storageRef)
    }
    
    var descriptionYo: String?
    var name: String?
    var storageReff: StorageReference?
    
    private var donutsPage1Struct = [myDonutPage1Struct]()
    private var mcafeeStructt = [myMcafeeStruct]()
     var flowLayout = GridLayout()
    
    lazy var donutsCollection = Firestore.firestore().collection("donuts")
    
    lazy var donutsCollectionDoc = Firestore.firestore().collection("donuts").document("")
    
    lazy var mcafeCatCollection = Firestore.firestore().collection("Mcafes")
    
  
    var sugarShackLogo: StorageReference {
        return Storage.storage().reference().child("recImages").child("IMG_5438.jpg")
    }
    
   private var donuts = [myDonutPage1Struct]()
   private var coffee = [myMcafeeStruct]()
    
    var contentViewWidth : CGFloat = 1.0
    lazy var contentView: UIView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentSize.height = 500
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentSize.height = 800
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    
    var topImageContainerWidth : CGFloat = 1.0
    lazy var topImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    lazy var topImage: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false//        view.image = UIImage(imageLiteralResourceName: "sugar-shack-richmond-best")
        //        view.frame = CGRect(x: 1000, y: 1000, width: 375, height: 200)
        view.contentMode = .scaleAspectFit
        view.image = UIImage(imageLiteralResourceName: "sugar-shack-richmond-best")
        return view
    }()
    
    
    var topLblContainerWidth : CGFloat = 1.0
    lazy var topLblContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    lazy var topLbll: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Sugar Shack"
        view.textAlignment = .center
        let customFont = UIFont(name: "AgentOrange", size: 25)
        view.adjustsFontForContentSizeCategory = true
        view.font = customFont
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 7
        return view
    }()
    
    var middleImageContainerWidth : CGFloat = 1.0
    lazy var middleImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    
    lazy var middleImage: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(imageLiteralResourceName: "sugar-shack-richmond-best")
        return view
    }()
    
    var middleLblContainerWidth : CGFloat = 1.0
    lazy var middleLblContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white

        return view
    }()
    
    lazy var middleLbll: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "I'm Just Doing Me Nothing Less Boss"
        view.textAlignment = .center
        let customFont = UIFont(name: "AgentOrange", size: 25)
        view.adjustsFontForContentSizeCategory = true
        view.font = customFont
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 4
        return view
    }()

    lazy var gridCollectionView: UICollectionView = {
        
        let cV = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        //        cV.backgroundColor = UIColor(hex: "ffffe")
        cV.backgroundColor = UIColor.black
        cV.showsVerticalScrollIndicator = false
        cV.showsHorizontalScrollIndicator = false
        cV.translatesAutoresizingMaskIntoConstraints = false
        cV.dataSource = self
        cV.delegate = self
        
        return cV
    }()
    
    lazy var gridCollectionView2: UICollectionView = {
        
        let cV = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        cV.backgroundColor = UIColor.black
        cV.showsVerticalScrollIndicator = false
        cV.showsHorizontalScrollIndicator = false
        cV.translatesAutoresizingMaskIntoConstraints = false
        cV.dataSource = self
        cV.delegate = self
        return cV
    }()
    
    fileprivate func setupViews() {
        addViews()
        constrainViews()
    }
    
    fileprivate func addViews() {
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(topImageContainer)
        scrollView.addSubview(topLblContainer)
        scrollView.addSubview(middleLblContainer)
        scrollView.addSubview(middleImageContainer)
        scrollView.addSubview(gridCollectionView)
        
        topImageContainer.addSubview(topImage)
        topLblContainer.addSubview(topLbll)
        
        middleImageContainer.addSubview(middleImage)
        middleLblContainer.addSubview(middleLbll)
    }
    
    
    fileprivate func constrainViews() {

        //SETUP CONTAINERVIEWS
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//
        
        scrollView.stack([topLblContainer, topImageContainer, middleLblContainer, middleImageContainer, UIView()], axis: .vertical, width: 375, height: 800, spacing: 0)
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 800).isActive = true
        
        
        topImageContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topImageContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        topImageContainer.heightAnchor.constraint(equalToConstant: 300).isActive = true


        topLblContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topLblContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        topLblContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true


        
        middleImageContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        middleImageContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        middleImageContainer.heightAnchor.constraint(equalToConstant: 300).isActive = true

        
        middleLblContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        middleLblContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        middleLblContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true

   
//        topImageContainer.stack([topImage], axis: .vertical, width: 375, height: 300, spacing: 0)
        topImage.heightAnchor.constraint(equalToConstant: 400).isActive = true
        topImage.widthAnchor.constraint(equalTo: topImageContainer.widthAnchor).isActive = true
        topImage.centerYToSuperview()
        topImage.centerXToSuperview()
        
        //        topLblContainer.stack([lbll, UIView()], axis: .vertical, width: 375, height: 1000, spacing: 0)
        topLbll.heightAnchor.constraint(equalToConstant: 50).isActive = true
        topLbll.widthAnchor.constraint(equalTo: topLblContainer.widthAnchor).isActive = true
        topLbll.centerYToSuperview()
        topLbll.centerXToSuperview()

//        middleImageContainer.stack([middleImage, UIView()], axis: .vertical, width: 375, height: 100, spacing: 0)
        middleImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        middleImage.widthAnchor.constraint(equalTo: middleImageContainer.widthAnchor).isActive = true
        middleImage.centerYToSuperview()
        middleImage.centerXToSuperview()

//        middleLblContainer.stack([middleLbll, UIView()], axis: .vertical, width: 375, height: 100, spacing: 0)
        middleLbll.heightAnchor.constraint(equalToConstant: 100).isActive = true
        middleLbll.widthAnchor.constraint(equalTo: middleLblContainer.widthAnchor).isActive = true
        middleLbll.centerYToSuperview()
        middleLbll.centerXToSuperview()
        
        
       
        
        gridCollectionView.register(ProductsCell.self, forCellWithReuseIdentifier: "WeAiet")
        gridCollectionView.layoutSubviews()
        gridCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        gridCollectionView.topAnchor.constraint(equalTo: middleLblContainer.bottomAnchor).isActive = true
        gridCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        gridCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        gridCollectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true


//
//        gridCollectionView2.register(ProductsCell.self, forCellWithReuseIdentifier: "WeAiet")
//        gridCollectionView2.layoutSubviews()
//        gridCollectionView2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//        gridCollectionView2.topAnchor.constraint(equalTo: middleImage.bottomAnchor).isActive = true
//        gridCollectionView2.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//        //        middleImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        gridCollectionView2.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        gridCollectionView2.bottomAnchor.constraint(equalTo: hiddenButton.topAnchor).isActive = true
//
//        hiddenButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//        hiddenButton.topAnchor.constraint(equalTo: gridCollectionView2.bottomAnchor).isActive = true
//        hiddenButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//        hiddenButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        hiddenButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }



    func getMcafeDocumentNames() {
        mcafeCatCollection.getDocuments { (snapshot, _) in
            
    
            //            /decode entire collection documents into pretty json for tables collectionviews and so on
            let myMcafeeJSONData: [myMcafeeStruct] = try! snapshot!.decoded()
            self.coffee = myMcafeeJSONData
            
            DispatchQueue.main.async {
        
                self.gridCollectionView.reloadData()
//                self.downloadGIF.isHidden = true
//                self.downloadGIF.stopAnimating()
            }
            
        }
    }
    
    
    func getDonutDocument() {
        mcafeCatCollection.getDocuments { (snapshot, _) in
            
            //            /decode entire collection documents into pretty json for tables collectionviews and so on
            let myMcafeeJSONData: [myMcafeeStruct] = try! snapshot!.decoded()
            self.coffee = myMcafeeJSONData
            
            DispatchQueue.main.async {
                 self.gridCollectionView.reloadData()
//                self.downloadGIF.isHidden = true
//                self.downloadGIF.stopAnimating()
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            
        case gridCollectionView:
            return mcafeeStructt.count
            
        default: return 0
            
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
            
        case gridCollectionView:
            
            //                collectionView2.isHidden = false
            //
            guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.Id, for: indexPath) as? ProductsCell else { return UICollectionViewCell() }
            //
            //                cell2.catagoryName.text = mcafeeStructt[indexPath.row].catagoryName
            //                cell2.catagoryName.textColor = UIColor(hex: "f25c23")
            //
            //                cell2.contentView.backgroundColor  = UIColor(hex: "f9f3e7")
            //                cell2.backgroundColor = UIColor(hex: "ffffe")
            
            
            let imagesArray = mcafeeStructt[indexPath.row].imageRef
            let storageRef = Storage.storage().reference().child("coffeImages").child(imagesArray)
            cell2.productImageee.sd_setImage(with: storageRef)
            
            return cell2
            
        case gridCollectionView2:
            
            //            gridCollectionView2.isHidden = false
            
            guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "WeAiet", for: indexPath) as? ProductsCell else { return UICollectionViewCell() }
            
            //            cell2.catagoryName.text = mcafeeStructt[indexPath.row].catagoryName
            //            cell2.catagoryName.textColor = UIColor(hex: "f25c23")
            //
            //            cell2.contentView.backgroundColor  = UIColor(hex: "ffffe")
            ////            UIColor(hex: "f9f3e7")
            //            cell2.backgroundColor = UIColor(hex: "ffffe")
            
            let imagesArray = mcafeeStructt[indexPath.row].imageRef
            let storageRef = Storage.storage().reference().child("coffeImages").child(imagesArray)
            cell2.productImageee.sd_setImage(with: storageRef)
            
            return cell2
            
        default:
            
            return RandomCell.init()
        }
    }
}
