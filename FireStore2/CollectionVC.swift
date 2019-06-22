import Foundation
import UIKit

import Firebase
import FirebaseFirestore
import FirebaseStorage
import SDWebImage
import FirebaseUI
import ARKit
import SceneKit
import TinyConstraints


//extension HomeScreenVC {
//
//    enum ViewControllerSegue: String {
//        typealias RawValue = String
//
//        case coffeSeg
//        case qSeg
//        case qARSegue
//    }
//
//}


extension HomeScreenVC: UICollectionViewDelegateFlowLayout {

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

protocol SourceForA{
    func prepare(for segue: UIStoryboardSegue, from sender: Any?, toC vc: DetailVC)
}




class HomeScreenVC : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
  
//    var sugarShackOrderLink = "https://www.sugarshackdmv.com/pre-orders/"
//    var sugarShackCateringLink = "https://www.sugarshackdmv.com/services/"
//    var sugarShackShopLink = "https://squareup.com/store/sugarshackdonuts/"
    
    var detailVC = DetailVC()
    
    
    var flowLayout = GridLayout()

    private var donutsPage1Struct = [myDonutPage1Struct]()
    private var mcafeeStructt = [myMcafeeStruct]()

    lazy var donutsCollection = Firestore.firestore().collection("donuts")
    
    lazy var donutsCollectionDoc = Firestore.firestore().collection("donuts").document("")
    
    lazy var mcafeCatCollection = Firestore.firestore().collection("Mcafes")

    
    @IBOutlet weak var collectionViewDonuts: UICollectionViewFlowLayout!
    @IBOutlet weak var pagecontrols: UIPageControl!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewQ: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var bottomCollection: UICollectionView!
    @IBOutlet weak var downloadGIF: UIImageView!
    
//    @IBOutlet weak var downloadIndicator: UIActivityIndicatorView!
//    @IBOutlet weak var firebaseLabel: UILabel!
//    @IBOutlet weak var logoImage: UIImageView!
    
    //Stock Banners
    var sugarShackLogo: StorageReference {
        return Storage.storage().reference().child("images").child("sugar-shack-richmond-best.jpg")
    }
    
    private var indexOfCellBeforeDragging = 0
    var x = 1
    
    
    var contentViewWidth : CGFloat = 1.0
    lazy var contentView: UIView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 2000
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 2000
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    lazy var testLabel: UILabel = {
        let testLabelBih = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.contentSize.height = 1057
        view.backgroundColor = UIColor.blue
        
        return testLabelBih
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
        
        //        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        //        let displayWidth: CGFloat = view.frame.width
        //        let displayHeight: CGFloat = view.frame.height
        //
        ////        let cV = UICollectionView.init(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight), collectionViewLayout: flowLayout)
        
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
        
        //        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        //        let displayWidth: CGFloat = view.frame.width
        //        let displayHeight: CGFloat = view.frame.height
        //
        ////        let cV = UICollectionView.init(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight), collectionViewLayout: flowLayout)
        return cV
    }()
    
    
    lazy var topImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(imageLiteralResourceName: "sugar-shack-richmond-best")
//        view.frame = CGRect(x: 1000, y: 1000, width: 375, height: 200)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var middleImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(imageLiteralResourceName: "sugar-shack-richmond-best")
        //        view.frame = CGRect(x: 0, y: 0, width: 375, height: 200)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var gifImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(imageLiteralResourceName: "sugar-shack-richmond-best")
    
        return view
        
    }()
    
    lazy var pageController: UIPageControl = {
        
        var pageControl = UIPageControl()
        return pageControl
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                setupViews()
        
        view.backgroundColor = UIColor.white
//        CollectionViewSetupDelegates()
        getMcafeDocumentNames()
        getDonutJson()
        
        
    }
    
    
//    fileprivate func CollectionViewSetupDelegates() {
//
//        //        downloadGIF.loadGif(name: "tasty")
//        collectionViewQ.delegate = self
//        collectionViewQ.dataSource = self
//        //        collectionView2.delegate = self
//        //        collectionView2.dataSource = self
//        //        topCollectionView.delegate = self
//        //        topCollectionView.dataSource = self
//    }
    
    fileprivate func setupViews() {
        addViews()
        constrainViews()
    }
    
    
    fileprivate func addViews() {
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(topImage)
        scrollView.addSubview(gridCollectionView)
        scrollView.addSubview(gridCollectionView2)
        scrollView.addSubview(middleImage)
        
    }
    
    
    fileprivate func constrainViews() {
        
        
    
//        scrollView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        
        contentView.height(3000)
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    
        
        
    //contentView Setup
        //NEED TO REFACTOR
        scrollView.stack([topImage, gridCollectionView, middleImage, gridCollectionView2, UIView()], axis: .vertical, width: 375, height: 3000, spacing: 50)
        
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 3000).isActive = true
        
        
        
        topImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topImage.bottomAnchor.constraint(equalTo: gridCollectionView.topAnchor).isActive = true
        topImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        topImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
    
        gridCollectionView.register(ProductsCell.self, forCellWithReuseIdentifier: "WeAiet")
        gridCollectionView.layoutSubviews()
        gridCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        gridCollectionView.topAnchor.constraint(equalTo: topImage.bottomAnchor).isActive = true
        gridCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        gridCollectionView.bottomAnchor.constraint(equalTo: middleImage.topAnchor).isActive = true
        gridCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        middleImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        middleImage.topAnchor.constraint(equalTo: gridCollectionView.bottomAnchor).isActive = true
        middleImage.bottomAnchor.constraint(equalTo: gridCollectionView2.topAnchor).isActive = true
        middleImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        middleImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        gridCollectionView2.register(ProductsCell.self, forCellWithReuseIdentifier: "WeAiet")
        gridCollectionView2.layoutSubviews()
        gridCollectionView2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        gridCollectionView2.topAnchor.constraint(equalTo: middleImage.bottomAnchor).isActive = true
        gridCollectionView2.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//        middleImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        gridCollectionView2.heightAnchor.constraint(equalToConstant: 200).isActive = true
        

        
    }
    
    var completionHandler:((String) -> String)?

    
//    MCDONaldsWay

 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
            
            
        case gridCollectionView:
            
            
            print(indexPath.description)
            detailVC.name = mcafeeStructt[indexPath.row].catagoryName
            detailVC.descriptionYo = mcafeeStructt[indexPath.row].des
            let imagesArray = mcafeeStructt[indexPath.row].imageRef
            let storageRef = Storage.storage().reference().child("coffeImages").child(imagesArray)
            detailVC.storageReff = storageRef
//            detailVCC.descriptionYo = mcafeeStructt[indexPath.row].catagoryName
            self.navigationController?.pushViewController(detailVC, animated: true)

       
        default: break
            
        }
    }

    // Refactor Identifiers
    //Add cell reususe and dynamic caching
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
                
                
                cell2.productName.text = mcafeeStructt[indexPath.row].catagoryName
                
//                    cell2.productDescription.text = mcafeeStructt[indexPath.row].des
                
                return cell2
            
        case gridCollectionView2:

//            gridCollectionView2.isHidden = false

            guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "WeAiet", for: indexPath) as? ProductsCell else { return UICollectionViewCell() }

            cell2.productName.text = mcafeeStructt[indexPath.row].catagoryName
//            
//             cell2.productDescription.text = mcafeeStructt[indexPath.row].des
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
           switch collectionView {
            
            
           case gridCollectionView2:
            return mcafeeStructt.count
            
           case gridCollectionView:
            return mcafeeStructt.count
            
           default: return 0
           
        }
        
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, segue: UIStoryboardSegue) {
        
        switch collectionView {
            
        case gridCollectionView:
            
            guard let cell = collectionView.cellForItem(at: indexPath) else { return }
                performSegue(withIdentifier: "coffeSegue", sender: cell)
    
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            
            present(vc, animated: true, completion: nil)
//
//        case gridCollectionView:
//
//             guard let cell = collectionView.cellForItem(at: indexPath) else { return }
//             performSegue(withIdentifier: "qSeg", sender: cell)
//
            
            default:
                print("fuck")
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        switch segue.identifier {
            
        //set info for products from mainview
//        case "qSeg":
//
//            guard let indexPath2 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
//            guard let detailViewController = segue.destination as? DetailVC else { return }
//
//
//            detailViewController.descriptionYo = donutsPage1Struct[indexPath2.row].description
//            detailViewController.name = donutsPage1Struct[indexPath2.row].name
//
//            let imagesArray = donutsPage1Struct[indexPath2.row].imageRef
//
//            var homeDonutImages: StorageReference {
//                return Storage.storage().reference().child("images").child(imagesArray)
//            }
//
//            detailViewController.storageRef = homeDonutImages
            
            
        case "coffeSegue":
            
            guard let indexPath2 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
            guard let detailViewController = segue.destination as? DetailVC else { return }
            
            
//            detailViewController.descriptionYo = mcafeeStructt[indexPath2.row].catagoryName
//            detailViewController.name = mcafeeStructt[indexPath2.row].catagoryName
            
            let imagesArray = mcafeeStructt[indexPath2.row].imageRef
            
            var homeDonutImages: StorageReference {
                return Storage.storage().reference().child("coffeImages").child(imagesArray)
            }
            detailViewController.storageReff = homeDonutImages
            
            
//        case "qARSegue":
//            guard let indexPath2 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
//            guard let arViewController = segue.destination as? ARVC else { return }
//            arViewController.descriptionBitch = donutsPage1Struct[indexPath2.row].name
            
            
            
            print("nothing")
            //            guard let indexPath2 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
            //            guard let arViewController = segue.destination as? ImageRecViewController else { return }
            
        default:
            return
        }
    }
    
    
//    func pushToDetailVC() {
//
//         let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        segue.prepare(sender:sender)
//    }

//    func prepare(for segue: UIStoryboardSegue, from sender: Any?, toC vc: DetailVC) {
//        switch segue.identifier {
//            //
//                    //set info for products from mainview
//                    case "qSeg":
//                     guard let detailViewController = segue.destination as? DetailVC else { return }
//
//
//                        guard let indexPath2 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
//
//                        detailViewController.descriptionYo = donutsPage1Struct[indexPath2.row].description
//                        detailViewController.name = donutsPage1Struct[indexPath2.row].name
//
//                        let imagesArray = donutsPage1Struct[indexPath2.row].imageRef
//
//                        var homeDonutImages: StorageReference {
//                            return Storage.storage().reference().child("images").child(imagesArray)
//                        }
//
//                        detailViewController.storageRef = homeDonutImages
//
////
//                    case "coffeSeg":
//
//                        guard let indexPath2 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
//                        guard let detailViewController = segue.destination as? DetailVC else { return }
//
//
//                        detailViewController.descriptionYo = mcafeeStructt[indexPath2.row].catagoryName
//                        detailViewController.name = mcafeeStructt[indexPath2.row].catagoryName
//
//                        let imagesArray = mcafeeStructt[indexPath2.row].imageRef
//
//                        var homeDonutImages: StorageReference {
//                            return Storage.storage().reference().child("coffeImages").child(imagesArray)
//                        }
//                        detailViewController.storageRef = homeDonutImages
//
//
//                    case "qARSegue":
//                        guard let indexPath2 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
//                        guard let arViewController = segue.destination as? ARVC else { return }
//                        arViewController.descriptionBitch = donutsPage1Struct[indexPath2.row].name
//
//
//
//                        print("nothing")
//                        //            guard let indexPath2 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
//                        //            guard let arViewController = segue.destination as? ImageRecViewController else { return }
//
//                    default:
//                        return
//                    }
//    }
    

    
 
    
    func getMcafeDocumentNames() {
        mcafeCatCollection.getDocuments { (snapshot, _) in
            
            //            /decode entire collection documents into pretty json for tables collectionviews and so on
            let myMcafeeJSONData: [myMcafeeStruct] = try! snapshot!.decoded()
            self.mcafeeStructt = myMcafeeJSONData
            
            DispatchQueue.main.async {
                //reload ColectionView EveryTime We Download
//                self.collectionView2.reloadData()
                
//                self.collectionViewQ.reloadData()
                
                self.gridCollectionView.reloadData()
            
 //                                self.downloadGIF.isHidden = true
//                                self.downloadGIF.stopAnimating()
            }
            
            
        }
    }

    // TURN TO SINGLETON CLASS (SHARED) STATIC FUNC!
    func getDonutJson() {
        donutsCollection.getDocuments { (snapshot, _) in
            
            //            /decode entire collection documents into pretty json for tables collectionviews and so on
            let myDonutsJSONData: [myDonutPage1Struct] = try! snapshot!.decoded()
            self.donutsPage1Struct = myDonutsJSONData
//
//            let donutInfoIndex = IndexPath()
//            let line3 = myDonutsJSONData[3]
            
            DispatchQueue.main.async {
                //reload ColectionView EveryTime We Download
//                self.collectionViewQ.reloadData()
                self.gridCollectionView2.reloadData()

                
//                self.downloadGIF.isHidden = true
//                self.downloadGIF.stopAnimating()
            }
            
        }
    }
    
    //        Get Title
    func getDonutDocJson() {
        donutsCollectionDoc.getDocument { (snapshot, _) in
            
            guard let snapshot = snapshot, snapshot.exists else {return}
            let data = snapshot.data()
            DispatchQueue.main.async {
                let description1 = data?["description"] as? String ?? ""
                let name1 = data?["name"] as? String ?? ""
                //            let description1 = data?["description"] as? String ?? ""
                //            let name1 = data?["name"] as? String ?? ""
                self.testLabel.text = name1
                
            }
            //            vc.navigationbartitle.text = name1
            
        }
    }

//
    func setTopLogo() {

        //Do this on first page alot! NEED HELPER
//        topLogo.sd_setImage(with: sugarShackLogo)

        //Need Helper
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("yourProjectImages")

//        if already exists stop grab from tmp

        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }

        sugarShackLogo.getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
            if let error = error {
                print("Error \(error)")
            } else {

                 DispatchQueue.main.async {
               self.topImage.image = UIImage(data: data!)
                self.topImage.adjustsImageSizeForAccessibilityContentSizeCategory = false
                //write data to tmp documents
                    }

            }
        })

    }

    

    
    func setTimer() {
        
        let _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(HomeScreenVC.autoScroll), userInfo: nil,
                                     repeats: true)
        //    }
        
    }
    func stopTimer(){
        
        
    }
    
    
    // create auto scroll
    @objc func autoScroll() {
        
        //        if topCollectionView.isHidden == true ||  collectionViewQ.isHidden == true ||  collectionView2.isHidden == true {
        //
        //            return
        //
        //        } else {
        
        self.pageController.currentPage = x
        
        if self.x < 6 {
            
            let indexPath = IndexPath(item: self.x, section: 0)
            self.gridCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
              self.gridCollectionView2.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.x = self.x + 1
            
            
        } else {
            self.x = 0
            self.gridCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            self.gridCollectionView2.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedItem != nil) {
            gridCollectionView.scrollToItem(at: context.nextFocusedItem as! IndexPath, at: .centeredHorizontally, animated: true)
            gridCollectionView2.scrollToItem(at: context.nextFocusedItem as! IndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    
}



