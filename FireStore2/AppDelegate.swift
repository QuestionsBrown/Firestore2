//
//  AppDelegate.swift
//  FireStore2
//
//  Created by Concetta Turner on 11/5/18.
//  Copyright © 2018 Concetta Turner. All rights reserved.
//

import SceneKit
import ARKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    override init() {
        FirebaseApp.configure()
    }

    var window: UIWindow?
    var navVC: UINavigationController?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
 
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let homeVC = HomeScreenVC()
        navVC = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navVC

//////
//            window = UIWindow(frame: UIScreen.main.bounds)
//            if let window = window {
//            let homeVC = HomeScreenVC()
//            navVC = UINavigationController(rootViewController: homeVC)
//
//            window.rootViewController = navVC
//            window.makeKeyAndVisible()

//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    //    func createTabBarController() {
    //
    //        let firstVc = collectionVC
    //        firstVc?.title = "First"
    //        firstVc?.view.backgroundColor =  UIColor.red
    //        firstVc?.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(named: "lilsugarshackimage"), tag: 0)
    //
    //        let secondVc = ARVC()
    //        secondVc.title = "Second"
    //        secondVc.view.backgroundColor =  UIColor.green
    //        secondVc.tabBarItem = UITabBarItem.init(title: "Location", image: UIImage(named: "lilsugarshackimage"), tag: 1)
    //
    //        let controllerArray = [firstVc, secondVc]
    //        tabBarCnt.viewControllers = controllerArray.map{ UINavigationController.init(rootViewController: $0 as! UIViewController)}
    //
    //        self.view.addSubview(tabBarCnt.view)
    //    }
    
    
    //    func setupTabar() {
    //
    //        collectionVC = HomeScreenVC()
    //        arVC = ARVC()
    //        arImageRecVC = ImageRecViewController()
    //
    //        let viewControllers = [HomeScreenVC(), SearchTableVC(), ARVC()]
    //
    //        tabBarCnt.viewControllers = viewControllers.map{ UINavigationController.init(rootViewController: $0)}
    //
    //        self.view.addSubview(tabBarCnt.view)
    //
    //
    //        collectionVC.tabBarItem.image = UIImage(named: "hommme")
    //        collectionVC.tabBarItem.selectedImage =
    //            UIImage(named: "hommme")
    //
    //
    //        arVC.tabBarItem.image = UIImage(named: "hommme")
    //        arVC.tabBarItem.selectedImage =
    //            UIImage(named: "hommme")
    //
    //
    //        arImageRecVC.tabBarItem.image = UIImage(named: "hommme")
    //        arImageRecVC.tabBarItem.selectedImage =
    //            UIImage(named: "hommme")
    //
    //    }
    
    // let quantity: String
    //    let sideName1:String
    //    let sideName2:String
    //    let sideName3:String
    //    let sideName4:String
    //    let scnName: String
    //    x: Int
    //    y: Int
    //    z: Int
    //    isAvaliable: Bool
    //    PageNumber: Int
    //    ItemNumber: Int
    //    let scnName: String
//    let segueName: String
//    let imagesCollectionName: String
////
//    
//    func Paginate () {
//    let first = db.collection("cities")
//        .order(by: "population")
//        .limit(to: 25)
//    
//    first.addSnapshotListener { (snapshot, error) in
//    guard let snapshot = snapshot else {
//    print("Error retreving cities: \(error.debugDescription)")
//    return
//    }
//    
//    guard let lastSnapshot = snapshot.documents.last else {
//    // The collection is empty.
//    return
//    }
//    
//    // Construct a new query starting after this document,
//    // retrieving the next 25 cities.
//    let next = db.collection("cities")
//    .order(by: "population")
//    .start(afterDocument: lastSnapshot)
//    
//    // Use the query for pagination.
//    // ...
//    }
//        
//    }
    
    //    or
    //    var collectionRef: CollectionReference {
    //        return Firestore.firestore().collection("donuts")
    //    }
    
    
    //Create Struct Array Documents Hold Tiny Json Queries. Tiny JSON Pockets = Data
    //    var blueberyydocRef: DocumentReference {
    //        return collectionRef.document("ANmPSd0MWIjU4b0qWCeUBlueberryCake")
    //    }
    //    or
    
    
    //    var glazedDocRef: DocumentReference {
    //        return collectionRef.document("ANmPSd0MWIjU4b0qWCeUBlueberryCake")
    //    }
    //    //    or
    //    lazy var glazedCollectionDocRef = Firestore.firestore().collection("donuts").document("ANmPSd0MWIjU4b0qWCeUBlueberryCake")
    
    
    //        guard let donutsScene = SCNScene(named: donutsScene, inDirectory: scnFolderName) else {return}
    
    //        guard let Fish = donutsScene.rootNode.childNode(withName: fishName, recursively: true) else {return}
    //        fish = Fish
    //        fish?.isHidden = false
    //        fish?.position = fishPosistion
    
    //        guard let mainAmbiant = donutsScene.rootNode.childNode(withName: ambiantName, recursively: true) else {return}
    //        mainLightSourceNode = mainAmbiant
    //
    //        let mainAmbientLight = SCNLight()
    //        mainAmbientLight.type = .ambient
    //        mainAmbientLight.intensity = 740
    //        mainLightSourceNode.light = mainAmbientLight
    //        mainLightSourceNode.isHidden = false


}


//            myUsers.forEach({ print($0) })


//         var imagesArray2 =
//            [Storage.storage().reference().child("images").child("blueberry-cake.png"),
//             Storage.storage().reference().child("images").child("glazed-cinnamon-roll.png"),
//             Storage.storage().reference().child("images").child("glazed.png"),
//             Storage.storage().reference().child("images").child("red-velvet.png"),
//             Storage.storage().reference().child("images").child("cinnamon-sugar.png"),
//             Storage.storage().reference().child("images").child("bacon-maple.png"),
//             Storage.storage().reference().child("images").child("tastes-like-a-samoa.png"),
//             Storage.storage().reference().child("images").child("chocolate-sprinkles.png")]
//        cell.productImage.sd_setImage(with: imagesArray2[indexPath.row])

//        let imageURLPlacer = cell.viewWithTag(1) as! UIImageView

//        imageURLPlacer.sd_setImage(with: donuts[indexPath.row].imageURL as? URL, completed: nil)
//        let downloadImageRef = imageReference.child(donuts[indexPath.row].imageURL)
//
//        let downloadtask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
//            if let data = data {
//                let image = UIImage(data: data)
////                self.downloadImages.image = image
//            }
//            print(error ?? "NO ERROR")
//        }
//
//        downloadtask.observe(.progress) { (snapshot) in
//            print(snapshot.progress ?? "NO MORE PROGRESS")
//        }
//
//        downloadtask.resume()

//
//        var placeholderImage = UIImage(named: "Honey-Lavender")


//Practice Firestore Pagenation
//    func paginateData() {
//
//        fetchingMore = true
//        var lastDocumentSnapshot = DocumentSnapshot!
//
//        var query: Query!
//
//        if donutsPage1Struct.isEmpty {
//            query = glazedDocRef.collection("donuts").order(by: "name").limit(to: 6)
//            print("First 6 rides loaded")
//        } else {
//            query = glazedDocRef.collection("donuts").order(by: "price").start(afterDocument: lastDocumentSnapshot).limit(to: 4)
//
//            print("Next 4 rides loaded")
//        }
//
//        query.getDocuments { (snapshot, err) in
//            if let err = err {
//                print("\(err.localizedDescription)")
//            } else if snapshot!.isEmpty {
//                self.fetchingMore = false
//                return
//            } else {
//                let newRides = try snapshot!.documents.compactMap({myDonutPage1Struct(from: $0.data() as! Decoder)})
//                self.rides.append(contentsOf: newRides)
//
//                //
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    self.collectionView.reloadData()
//                    self.fetchingMore = false
//                })
//
//                self.lastDocumentSnapshot = snapshot!.documents.last
//            }
//        }
//    }

//    func downloadImages2(imageName: String, imageRef: StorageReference) {
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
//        let targetUrl = tempDirectory.appendingPathComponent(imageName)
//
//        imageRef.write(toFile: targetUrl) { (url, error) in
//            if error != nil {
//                print("ERROR: \(error!)")
//            }else{
//                print("modelPath.write OKAY")
//                print(targetUrl.pathExtension)
//                print(targetUrl.absoluteURL)
//                print(targetUrl.absoluteString)
//                //                print(targetUrl.)
//            }
//        }
//
//        imageRef.getMetadata { (metaData, error) in
//            if error != nil {
//                print("ERROR: ", error!)
//            }else{
//                print("Metadata: \(metaData!)")
//            }
//        }
//
//
//    }
//

//Practice Firestore Pagenation
//    func paginateData() {
//
//        fetchingMore = true
//        var lastDocumentSnapshot = DocumentSnapshot!
//
//        var query: Query!
//
//        if donutsPage1Struct.isEmpty {
//            query = glazedDocRef.collection("donuts").order(by: "name").limit(to: 6)
//            print("First 6 rides loaded")
//        } else {
//            query = glazedDocRef.collection("donuts").order(by: "price").start(afterDocument: lastDocumentSnapshot).limit(to: 4)
//
//            print("Next 4 rides loaded")
//        }
//
//        query.getDocuments { (snapshot, err) in
//            if let err = err {
//                print("\(err.localizedDescription)")
//            } else if snapshot!.isEmpty {
//                self.fetchingMore = false
//                return
//            } else {
//                let newRides = try snapshot!.documents.compactMap({myDonutPage1Struct(from: $0.data() as! Decoder)})
//                self.rides.append(contentsOf: newRides)
//
//                //
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    self.collectionView.reloadData()
//                    self.fetchingMore = false
//                })
//
//                self.lastDocumentSnapshot = snapshot!.documents.last
//            }
//        }
//    }
//
//  Need to create structs of all items/pages with download code in it
// NEED TO TURN TO SINGLETON CLASS (SHARED) STATIC FUNC!
//Get single instance query for precise title, number, description, ect.
//need error safeguard
//Find Out How Many Are Needed For Demo Application Walkthrough



// TURN TO SINGLETON CLASS (SHARED) STATIC FUNC!
//    func getClohingJson2(indexPath: IndexPath) {
//        usersCollection2ndRow.getDocuments { (snapshot, _) in
//
//            let myUsers: [clothing] = try! snapshot!.decoded()
//            self.clothingfr = myUsers
//
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }

//        } else {
//
//            guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "WeAiet2", for: indexPath) as? ProductsCell else { return UICollectionViewCell() }
//
//            cell2.productNameLabel.text = mcafeeStructt[indexPath.row].catagoryName
//
//            return cell2
//
//        }


//             arviewController.dessertsWorld.viewItemDirectly(relativeTransform: (arviewController.sceneView.session.currentFrame?.camera.transform)!)


//buttonassaignedfunctionBasedOnExactItem
//            detailViewController.sideOption1 = donutsPage1Struct[indexPath2.row].sideOption1
//            detailViewController.sideOption1Price = donutsPage1Struct[indexPath2.row].sideOption1Price

//TRYING TO SET IMAGES IN PREPARE NOT DIDLOAD
//USE ENUMS TO FILTER THROUGH FIREBASE DOCUMENTS
//// //ALL NODE NAMES JSON

// //Get exact reference you need per upload. 1-4 PBR Images
//
//ORdirect URL
//                       detailViewController.img.sd_setImage(with: storageBih)
//            detailViewController.img.sd_setImage(with: URL(string: storageBih.fullPath))

//
//            detailViewController.img.sd_setImage(with: URL(string: donutsPage1Struct[indexPath2.row].imageRef))



//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSize = CGSize(width: collectionView.bounds.width, height: 50)
//        return itemSize
//    }

//
//NEEDS REFACTORING BADLY 2x per item non dynamic with firebase
//func changeImage(indexPath: IndexPath) {
//    
//    //REFACTOR NEEDED SNEAKY WAY OF PICTURES
//    switch lbl.text {
//        //            60 tops per catagory
//    //USE QUICK ENUM FOR BOTH NAME AND REFERENCE STORAGE IMAGE
//    case "GLAZED":
//        //SET MULTIPLE IMAGES INSIDE OR GIF
//        img.sd_setImage(with: glazed)
//        
//    case "GLAZED CINNAMON":
//        img.sd_setImage(with: glazedCinnamonRoll)
//        
//    case .none:
//        print("kgkug")
//    case .some(_):
//        print("kgkug")
//    }
//    
//    
//}



//    func createTabarController() {
//
//
//
//
//    }

//
//        func createTabBarController() {
//
//             var tabBarCnt = 3
//
//            let firstVc = arImageRecVC
//            firstVc?.title = "First"
//            firstVc?.view.backgroundColor =  UIColor.red
//            firstVc?.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(named: "lilsugarshackimage"), tag: 0)
//
//            let secondVc = ARVC()
//            secondVc.title = "Second"
//            secondVc.view.backgroundColor =  UIColor.green
//            secondVc.tabBarItem = UITabBarItem.init(title: "Location", image: UIImage(named: "lilsugarshackimage"), tag: 1)
//
//            let thirdVc = HomeScreenVC()
//            secondVc.title = "Second"
//            secondVc.view.backgroundColor =  UIColor.green
//            secondVc.tabBarItem = UITabBarItem.init(title: "Location", image: UIImage(named: "lilsugarshackimage"), tag: 1)
//
////            let controllerArray = [firstVc, secondVc]
////            tabBarCnt.viewControllers = controllerArray.map{ UINavigationController.init(rootViewController: $0 as! UIViewController)}
////
////            self.view.addSubview(tabBarCnt.view)
//        }




//        func setupTabar() {
//
//            collectionVC = HomeScreenVC()
//            arVC = ARVC()
//            arImageRecVC = ImageRecViewController()
//
//            let viewControllers = [HomeScreenVC(), SearchTableVC(), ARVC()]
//
//            tabBarCnt.viewControllers = viewControllers.map{ UINavigationController.init(rootViewController: $0)}
//
//            self.view.addSubview(tabBarCnt.view)
//
//
//            collectionVC.tabBarItem.image = UIImage(named: "hommme")
//            collectionVC.tabBarItem.selectedImage =
//                UIImage(named: "hommme")
//
//
//            arVC.tabBarItem.image = UIImage(named: "hommme")
//            arVC.tabBarItem.selectedImage =
//                UIImage(named: "hommme")
//
//
//            arImageRecVC.tabBarItem.image = UIImage(named: "hommme")
//            arImageRecVC.tabBarItem.selectedImage =
//                UIImage(named: "hommme")
//
//        }
//
//
