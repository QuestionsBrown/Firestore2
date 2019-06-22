//
//  FBDownloadHelper.swift
//  FireStore2
//
//  Created by Concetta Turner on 3/29/19.
//  Copyright © 2019 Concetta Turner. All rights reserved.
//

import Foundation
import SceneKit
import ARKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseUI




//PLACE FB STRUCTS HERE
struct myDonutPage1Struct: Decodable {
    let name: String
    let description: String
    let price: String
    let imageRef: String
    let imageURL: String
}


//Coffee & Classics. Frappe Latte. Machiatto. Mocha
struct myMcafeeStruct: Decodable {
    let catagoryName: String
    let imageRef: String
    let imageURL: String
    let des: String
}

//FireBase Titles
struct topLabel: Decodable {
    let name: String
    let description: String
    let price: String
    let imageRef: String
//    let storageRef: StorageReference
}

struct ImageRecStruct: Decodable {
    let name: String
    let description: String
}


//connect storage reference struct with fiebase clound functions
struct arrayScnReferences {
    var sceneReferenceArray: [StorageReference] = []
}


//diff between computed with initilizers and computed without. Plus regeular with and without initilizers
class arrayScnReferences2: StorageReference {
    
    var blueBerryCakeImage: StorageReference {
        return Storage.storage().reference().child("images").child("blueberry-cake.png")
    }
    var glazedCinnamonRoll: StorageReference {
        return Storage.storage().reference().child("images").child("glazed-cinnamon-roll.png")
    }
    
    var glazed: StorageReference {
        return Storage.storage().reference().child("images").child("glazed.png")
    }
    
}


class DownloadHelper  {
    
    private init() {}
    static let shared = DownloadHelper()
    
    
    func loadImageAsyncFB(imageName: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        
//        var imageURL = imageName "https://firebasestorage.googleapis.com/v0/b/firestore2-4331a.appspot.com/o/recImages%2FIMG_5438.jpg?alt=media&token=22024a5f-88b7-4f83-8d83-9f8eea712b99"
        
        let imageURL = imageName
        
        let url = URL(string: imageURL)!
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let dataVar = data, error == nil else {
                
                DispatchQueue.main.async {
                    completion(nil, error)
                    print("Error")
                }
                return
            }
            
            let image = UIImage(data: dataVar)
            
            DispatchQueue.main.async {
                completion(image, nil)
                print("saved")
            }
            
            
            }.resume()
    }
    
    
     func loadImageAsync(imageName: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        
        var imageURL = "https://firebasestorage.googleapis.com/v0/b/firestore2-4331a.appspot.com/o/recImages%2FIMG_5438.jpg?alt=media&token=22024a5f-88b7-4f83-8d83-9f8eea712b99"
        
        let url = URL(string: imageURL)!
    

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let dataVar = data, error == nil else {

                DispatchQueue.main.async {
                    completion(nil, error)
                    print("Error")
                }
                return
            }
            
            let image = UIImage(data: dataVar)
            
            DispatchQueue.main.async {
                completion(image, nil)
                print("saved")
            }
            

            }.resume()
    }
    
    func loadImageFB(imageName: String, imageRef: StorageReference, completion: @escaping (UIImage?, Error?) -> Void) {

            imageRef.getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
                
                guard let data = data, error == nil else {
                    
                    DispatchQueue.main.async {
                        completion(nil, error)
                        print("Error")
                    }
                    return
                }
                
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    completion(image, nil)
                    print("saved")
                }
        
    })
}
                
    
    func downloadImages(imageName: String, imageRef: StorageReference, scannableImage: UIImage) {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
            let targetUrl = tempDirectory.appendingPathComponent(imageName)
    
            imageRef.write(toFile: targetUrl) { (url, error) in
                if error != nil {
                    print("ERROR: \(error!)")
                }else{
    
                    print("modelPath.write OKAY")
                    print(targetUrl.pathExtension)
                    print(targetUrl.absoluteURL)
                    print(targetUrl.absoluteString)
    //                print(targetUrl.)
    
    //                imageDownloaded = UIImage(contentsOfFile: targetUrl.absoluteString)!
                }
                
            }
    
            imageRef.getMetadata { (metaData, error) in
                if error != nil {
                    print("ERROR: ", error!)
                }else{
                    print("Metadata: \(metaData!)")
                }
            }
    
    
        }
    
//    func cacheImages(_ urls: [URL], completion: (() -> Void)? = nil) {
//        var imagesProcessed = 0
//        let downloader = ImageDownloader(name: "imageDownloaderJob")
//        downloader.sessionConfiguration.httpMaximumConnectionsPerHost = 1
//        urls.forEach({
//            let cacheKey = $0.absoluteString
//            let isImageCached = ImageCache.default.isImageCached(forKey: cacheKey).cached
//            if !isImageCached {
//                downloader.downloadImage(with: $0, options: [], progressBlock: nil) {
//                    (image, error, url, data) in
//                    if let image = image {
//                        // cache image
//                        ImageCache.default.store(image, forKey: cacheKey)
//                    }
//                }
//            } else {
//                imagesProcessed += 1
//                if imagesProcessed == urls.count {
//                    completion?()
//                }
//            }
//        })
//    }


    func downlaodSCN(scnName: String, scnRef: StorageReference){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
        let targetUrl = tempDirectory.appendingPathComponent(scnName)
        
        //                print(targetUrl.pathExtension)
        //                print(targetUrl.absoluteURL)
        //                print(targetUrl.absoluteString)
        
        //check if already exists Help
        
        //        do try cache
        scnRef.write(toFile: targetUrl) { (url, error) in
            if error != nil {
                print("ERROR: \(error!)")
            }else{
                print("modelPath.write OKAY")
                print(targetUrl.pathExtension)
                print(targetUrl.absoluteURL)
                print(targetUrl.absoluteString)
                
                //
                //                var sceneForNode: SCNScene? = nil
                //                do {
                //                    // load the 3D-Model node from directory path
                //                    sceneForNode = try SCNScene(url: targetUrl, options: nil)
                //                }catch{
                //                    print(error)
                //                }
                //
                //                guard let donutsScene = sceneForNode else {return}
                //
                //                let downloadedFish: SCNNode? = donutsScene.rootNode.childNode(withName: "polySurface1_meshId0_name_lambert1", recursively: true)
                //                downloadedFish?.isHidden = false
                //
                //                //prep all items in generic protocol either with helper or without
                //                guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
                //                self.hatRoot = HatRoot
                //                //        guard let donutsScene = SCNScene(named: donutsScene, inDirectory: scnFolderName) else {return}
                //
                //                //        guard let Fish = donutsScene.rootNode.childNode(withName: fishName, recursively: true) else {return}
                //                //        fish = Fish
                //                //        fish?.isHidden = false
                //                //        fish?.position = fishPosistion
                //
                //                //        guard let mainAmbiant = donutsScene.rootNode.childNode(withName: ambiantName, recursively: true) else {return}
                //                //        mainLightSourceNode = mainAmbiant
                //                //
                //                //        let mainAmbientLight = SCNLight()
                //                //        mainAmbientLight.type = .ambient
                //                //        mainAmbientLight.intensity = 740
                //                //        mainLightSourceNode.light = mainAmbientLight
                //                //        mainLightSourceNode.isHidden = false
                //
                //                let wrapperNode = SCNNode()
                //
                //                for child in donutsScene.rootNode.childNodes {
                //                    wrapperNode.addChildNode(child)
                //                }
                //                self.contentRootNode.addChildNode(wrapperNode)
                //                //        contentRootNode.rotation = SCNVector4Make(0, 0, 0, 0)
                //                self.rootNode.addChildNode(self.contentRootNode)
                //            }
                
                
            }
        }


        //make sure to write correct name or use medatata name inside load fucntion
        
        scnRef.getMetadata { (metaData, error) in
            if error != nil {
                print("ERROR: ", error!)
            }else{
                print("Metadata: \(metaData!)")
            }
        }
        
        
    }
}
    
//    Download Helper Protocol Variables
    //        var sceneForNodee: SCNScene? = nil
    //        var scnFolderName: String? = nil
    //        var hatScn: String? = nil
    //        var hatRootName: String? = nil
    //        var hatCatagoryName: String? = nil
    //        lazy var contentRootNode = SCNNode()
    
    
    //Learn Differences
    //    var itemRoot = SCNNode?.self
    //    var iteNode12 = SCNNode.self
    //    var itemNode123 = SCNNode?.self
    //    var itemNode1234 = SCNNode()
    //    var itemNodem: SCNNode? = nil
    //    var itemNodee: SCNNode
    //    var iteNode12345: SCNNode {
    //        let item = SCNNode()
    //        return item
    //    }
    //    var itemNode123456: SCNNode? {
    //        let item = SCNNode()
    //        return item
    //    }
    
    //make generic strcu of 12 Nodes
    //    lazy var hatNode2 = SCNNode()
    //    lazy var hatNode3 = SCNNode()
    //    lazy var hatNode4 = SCNNode()
    //    lazy var hatNode5 = SCNNode()
    //    lazy var hatNode6 = SCNNode()
    //    lazy var hatNode8 = SCNNode()
    //    lazy var hatNode9 = SCNNode()
    //    lazy var hatNode10 = SCNNode()
    //    lazy var hatNode11 = SCNNode()
    //    lazy var hatNode12 = SCNNode()
    
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    //    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    



enum worldArrayHolder: CaseIterable {
    case SidesW
    case BrunchW
    case LunchW
    case DinnerW
    case DessertsW
    
    init?(caseName: String) {
        for world in worldArrayHolder.allCases where "\(world)" == caseName {
            self = world
            return
        }
        
        return nil
        
    }
}

