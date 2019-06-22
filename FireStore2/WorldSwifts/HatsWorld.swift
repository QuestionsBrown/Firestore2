//
//  World.swift
//  FireStore2
//
//  Created by Concetta Turner on 1/4/19.
//  Copyright © 2019 Concetta Turner. All rights reserved.
//

import Foundation
import SceneKit
import ARKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseUI
//import SpriteKit
//import ModelIO
//import SceneKit.ModelIO

//mmulti dropdown pages under catagories
//Each
class HatsWorld: SCNScene, SCNPhysicsContactDelegate {
    
    private var donuts = [myDonutPage1Struct]()
    private var index: IndexPath = []
    
    //    var sceneReferenceArray: [StorageReference] = []
    //    var documentsArray: [DocumentReference] = []
    //        var collectionArray: [CollectionReference] = []
    
    //Create Struct Of Beginning Collections Catagories vars then (Put In Array) & Finally Intitilize So It Can Be Used Inside This Class
    lazy var donutCollection = Firestore.firestore().collection("donuts")
    
//    lazy var hatsCollection = Firestore.firestore().collection("donuts")
    
    //Create Struct Of  Individual .scn File StorageReferences vars then (Put In Array) & Finally Intitilize So It Can Be Used Inside This Class
    var scnReferencePage1: StorageReference {
        return Storage.storage().reference().child("ObjSCN").child("Brunch copy.scn")
    }
    
    var pbrImage: StorageReference {
        return Storage.storage().reference().child("pbrImages").child("lambert1_albedo")
    }
    
    

//    var scnReferencePage2: StorageReference {
//        return Storage.storage().reference().child("ObjSCN").child("HatPage2")
//    }
//    var scnReferencePage3: StorageReference {
//        return Storage.storage().reference().child("ObjSCN").child("HatPage3")
//    }
//    var scnReferencePage4: StorageReference {
//        return Storage.storage().reference().child("ObjSCN").child("HatPage4")
//    }
//    var scnReferencePage5: StorageReference {
//        return Storage.storage().reference().child("ObjSCN").child("HatPage5")
//    }


//    Page 1 generic Variables
    var sceneForNodee: SCNScene? = nil
    var mainLightSourceNode = SCNNode()
    let contentRootNode = SCNNode()
    var hatRoot = SCNNode()
    
    var scnName: String = "Brunch copy.scn"
    var hatScn: String = "Brunch copy.scn"
    var hatRootName: String = "BrunchRoot"
    
    var yeezyNode1 = SCNNode()
        let yeezyNode1Name: String = "Food"
    
    var hatnode2 = SCNNode()
        let hatNodeName2: String = "Shoes"
    
//    var yeezyNode1 = SCNNode()
//    let yeezyNode1Name: String = "Food"
//
//    var hatnode2 = SCNNode()
//    let hatNodeName2: String = "Shoes"
//
//    var yeezyNode1 = SCNNode()
//    let yeezyNode1Name: String = "Food"
//
//    var hatnode2 = SCNNode()
//    let hatNodeName2: String = "Shoes"
    
    //enum check if  irst letters and last digit
    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    
//    Page 2 generic Variables
//    var scnName: String = "Hat5objCopyscn.scn"
//    var ambiantName = "ambiant"
//    var sceneForNodee: SCNScene? = nil
//    var scnFolderName: String = "art.scnassets"
//    var hatScn: String = "Hat.scn"
//    let hatRootName: String = "HatRoot"
//    let hatCatagoryName: String = "HatCatagory"
//    let hatNode1Name: String = "Hat"
//    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
//    var hatRoot = SCNNode()
//
//    var item1 = SCNNode()
//    var item2 = SCNNode()
//    var item3 = SCNNode()
//    var item4 = SCNNode()
//    var item5 = SCNNode()
//    var item6 = SCNNode()
//    var item7 = SCNNode()
//    var item8 = SCNNode()
//    var item9 = SCNNode()
//    var item10 = SCNNode()
//    var item11 = SCNNode()
//    var item12 = SCNNode()
//
//    var mainLightSourceNode = SCNNode()
//    let contentRootNode = SCNNode()
    
////    Page 3 generic Variables
//    var scnName: String = "Hat5objCopyscn.scn"
//    var ambiantName = "ambiant"
//    var sceneForNodee: SCNScene? = nil
//    var scnFolderName: String = "art.scnassets"
//    var hatScn: String = "Hat.scn"
//    let hatRootName: String = "HatRoot"
//    let hatCatagoryName: String = "HatCatagory"
//    let hatNode1Name: String = "Hat"
//    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
//    var hatRoot = SCNNode()
//
//    var item1 = SCNNode()
//    var item2 = SCNNode()
//    var item3 = SCNNode()
//    var item4 = SCNNode()
//    var item5 = SCNNode()
//    var item6 = SCNNode()
//    var item7 = SCNNode()
//    var item8 = SCNNode()
//    var item9 = SCNNode()
//    var item10 = SCNNode()
//    var item11 = SCNNode()
//    var item12 = SCNNode()
//
//    var mainLightSourceNode = SCNNode()
//    let contentRootNode = SCNNode()
    
    
//    Page 4 generic Variables
//    var scnName: String = "Hat5objCopyscn.scn"
//    var ambiantName = "ambiant"
//    var sceneForNodee: SCNScene? = nil
//    var scnFolderName: String = "art.scnassets"
//    var hatScn: String = "Hat.scn"
//    let hatRootName: String = "HatRoot"
//    let hatCatagoryName: String = "HatCatagory"
//    let hatNode1Name: String = "Hat"
//    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
//    var hatRoot = SCNNode()
//
//    var item1 = SCNNode()
//    var item2 = SCNNode()
//    var item3 = SCNNode()
//    var item4 = SCNNode()
//    var item5 = SCNNode()
//    var item6 = SCNNode()
//    var item7 = SCNNode()
//    var item8 = SCNNode()
//    var item9 = SCNNode()
//    var item10 = SCNNode()
//    var item11 = SCNNode()
//    var item12 = SCNNode()
//
//    var mainLightSourceNode = SCNNode()
//    let contentRootNode = SCNNode()
    
//    Page 5 generic Variables
//    var scnName: String = "Hat5objCopyscn.scn"
//    var ambiantName = "ambiant"
//    var sceneForNodee: SCNScene? = nil
//    var scnFolderName: String = "art.scnassets"
//    var hatScn: String = "Hat.scn"
//    let hatRootName: String = "HatRoot"
//    let hatCatagoryName: String = "HatCatagory"
//    let hatNode1Name: String = "Hat"
//    let hatPosition: SCNVector3 = SCNVector3Make(0, 0, -4)
//    var hatRoot = SCNNode()
//
//    var item1 = SCNNode()
//    var item2 = SCNNode()
//    var item3 = SCNNode()
//    var item4 = SCNNode()
//    var item5 = SCNNode()
//    var item6 = SCNNode()
//    var item7 = SCNNode()
//    var item8 = SCNNode()
//    var item9 = SCNNode()
//    var item10 = SCNNode()
//    var item11 = SCNNode()
//    var item12 = SCNNode()
//
//    var mainLightSourceNode = SCNNode()
//    let contentRootNode = SCNNode()
    
    
    
override init() {
    super.init()
    
    //Determine which is needed to be loaded basd on??????

    getDonutJson(indexPath: index)
    downloadSetPg1()
//    setDownloadedTexturesPg1()
//    downloadSetPg2()
//    downloadSetPg3()
//    downloadSetPg4()
//    downloadSetPg5()
    
}

required init?(coder aDecoder: NSCoder) {
    fatalError("")
}
    
 
//    Replace Kabaq 2D ContainerView (pass completiom for auto node setting & naming after download code)
    func downloadSetPg1(){
        
        
        //test How Many MB Can Be Downloaded & not Shown At Once
        DownloadHelper.shared.downlaodSCN(scnName: scnName, scnRef: scnReferencePage1)
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
        let targetUrl = tempDirectory.appendingPathComponent(scnName)
        
        print(targetUrl.pathExtension)
        print(targetUrl.absoluteURL)
        print(targetUrl.absoluteString)
    
        var sceneForNode: SCNScene? = nil
        do {
            // load the 3D-Model node from directory path
            sceneForNode = try SCNScene(url: targetUrl, options: nil)
        }catch{
            
            //show alert that an error occured
            print(error)
        }
        
        guard let donutsScene = sceneForNode else {return}

        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
        hatRoot = HatRoot
        hatRoot.isHidden = false
        
        guard let Hat = donutsScene.rootNode.childNode(withName: self.hatNodeName2, recursively: true) else {return}
        hatnode2 = HatRoot
        hatnode2.isHidden = false
//
        guard let Yeezy = donutsScene.rootNode.childNode(withName: self.yeezyNode1Name, recursively: true) else {return}
        yeezyNode1 = HatRoot
        yeezyNode1.isHidden = false
        
//        let yeezyMaterial = SCNMaterial()
//        yeezyMaterial.lightingModel = .phong
//        yeezyMaterial.transparencyMode = .dualLayer
//        yeezyMaterial.fresnelExponent = 1.5
//        yeezyMaterial.isDoubleSided = true
//        yeezyMaterial.specular.contents = [UIColor.black]
//        yeezyMaterial.shininess = 35
        //usefirebaseSDUI
//        yeezyMaterial.diffuse.contents = UIImage(named: "lambert1_albedo")
//        //                yeezyMaterial.reflective.contents = UIImage(named: "art.scnassets/environment_blur.exr")
//        yeezyMaterial.roughness.contents = 1
//        hatnode2.geometry?.materials = [yeezyMaterial]

//
//        guard let Hat3 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
//
//        guard let Hat4 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
//
//        guard let Hat5 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
//
//        guard let Hat6= donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
//
//        guard let Hat7 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
//
//        guard let Hat8 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
//
//        guard let Hat9 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
        
//        guard let Hat10 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
//
//        guard let Hat11 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
//
//        guard let Hat12 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
        
        let wrapperNode = SCNNode()
        
        for child in donutsScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        contentRootNode.addChildNode(wrapperNode)
        //        contentRootNode.rotation = SCNVector4Make(0, 0, 0, 0)
        self.rootNode.addChildNode(contentRootNode)
        
    }
    
    func setDownloadedTexturesPg1(){

let yeezyMaterial = SCNMaterial()
yeezyMaterial.lightingModel = .phong
yeezyMaterial.transparencyMode = .dualLayer
yeezyMaterial.fresnelExponent = 1.5
yeezyMaterial.isDoubleSided = true
yeezyMaterial.specular.contents = [UIColor.black]
yeezyMaterial.shininess = 35
yeezyMaterial.diffuse.contents = UIImage(named: "yeezyboost350V2")
//                yeezyMaterial.reflective.contents = UIImage(named: "art.scnassets/environment_blur.exr")
yeezyMaterial.roughness.contents = 1
yeezyNode1.geometry?.materials = [yeezyMaterial]
        
    }
    
    
////    //MAKE ALL OPTINOL
////    func downloadSetPg2(){
////
//    //
//    //test How Many MB Can Be Downloaded & not Shown At Once
//    DownloadHelper.shared.downlaodSCN(scnName: scnName, scnRef: scnReferencePage1)
//
//    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//    let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
//    let targetUrl = tempDirectory.appendingPathComponent(scnName)
//
//    print(targetUrl.pathExtension)
//    print(targetUrl.absoluteURL)
//    print(targetUrl.absoluteString)
//
//    var sceneForNode: SCNScene? = nil
//    do {
//    // load the 3D-Model node from directory path
//    sceneForNode = try SCNScene(url: targetUrl, options: nil)
//    }catch{
//
//    //show alert that an error occured
//    print(error)
//    }
//
//    guard let donutsScene = sceneForNode else {return}
//
//    guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    hatRoot = HatRoot
//    hatRoot.isHidden = false
//
//    //        guard let Hat1 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat2 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat3 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat4 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat5 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat6= donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat7 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat8 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat9 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//
//    //        guard let Hat10 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat11 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//    //
//    //        guard let Hat12 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//    //        hatRoot = HatRoot
//    //        hatRoot.isHidden = false
//
//    let wrapperNode = SCNNode()
//
//    for child in donutsScene.rootNode.childNodes {
//    wrapperNode.addChildNode(child)
//    }
//    contentRootNode.addChildNode(wrapperNode)
//    //        contentRootNode.rotation = SCNVector4Make(0, 0, 0, 0)
//    self.rootNode.addChildNode(contentRootNode)
//
//}
//
//    func downloadSetPg3(){
//        
//        //test How Many MB Can Be Downloaded & not Shown At Once
//        DownloadHelper.shared.downlaodSCN(scnName: scnName, scnRef: scnReferencePage1)
//        
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
//        let targetUrl = tempDirectory.appendingPathComponent(scnName)
//        
//        print(targetUrl.pathExtension)
//        print(targetUrl.absoluteURL)
//        print(targetUrl.absoluteString)
//        
//        var sceneForNode: SCNScene? = nil
//        do {
//            // load the 3D-Model node from directory path
//            sceneForNode = try SCNScene(url: targetUrl, options: nil)
//        }catch{
//            
//            //show alert that an error occured
//            print(error)
//        }
//        
//        guard let donutsScene = sceneForNode else {return}
//        
//        guard let downloadedFish: SCNNode? = donutsScene.rootNode.childNode(withName: "polySurface1_meshId0_name_lambert1", recursively: true)  else {return}
//        
//        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        hatRoot = HatRoot
//        hatRoot.isHidden = false
//        
//        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        //        hatRoot = HatRoot
//        //        hatRoot.isHidden = false
//        //
//        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        //        hatRoot = HatRoot
//        //        hatRoot.isHidden = false
//        //
//        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        //        hatRoot = HatRoot
//        //        hatRoot.isHidden = false
//        //
//        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        //        hatRoot = HatRoot
//        //        hatRoot.isHidden = false
//        //
//        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        //        hatRoot = HatRoot
//        //        hatRoot.isHidden = false
//        //
//        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        //        hatRoot = HatRoot
//        //        hatRoot.isHidden = false
//        //
//        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        //        hatRoot = HatRoot
//        //        hatRoot.isHidden = false
//        //
//        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        //        hatRoot = HatRoot
//        //        hatRoot.isHidden = false
//        //
//        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
//        //        hatRoot = HatRoot
//        //        hatRoot.isHidden = false
//        
//        let wrapperNode = SCNNode()
//        
//        for child in donutsScene.rootNode.childNodes {
//            wrapperNode.addChildNode(child)
//        }
//        contentRootNode.addChildNode(wrapperNode)
//        //        contentRootNode.rotation = SCNVector4Make(0, 0, 0, 0)
//        self.rootNode.addChildNode(contentRootNode)
//        
//    }
//
    
    ////    func downloadSetPg2(){
    ////
    //    //
    //    //test How Many MB Can Be Downloaded & not Shown At Once
    //    DownloadHelper.shared.downlaodSCN(scnName: scnName, scnRef: scnReferencePage1)
    //
    //    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    //    let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
    //    let targetUrl = tempDirectory.appendingPathComponent(scnName)
    //
    //    print(targetUrl.pathExtension)
    //    print(targetUrl.absoluteURL)
    //    print(targetUrl.absoluteString)
    //
    //    var sceneForNode: SCNScene? = nil
    //    do {
    //    // load the 3D-Model node from directory path
    //    sceneForNode = try SCNScene(url: targetUrl, options: nil)
    //    }catch{
    //
    //    //show alert that an error occured
    //    print(error)
    //    }
    //
    //    guard let donutsScene = sceneForNode else {return}
    //
    //    guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    hatRoot = HatRoot
    //    hatRoot.isHidden = false
    //
    //    //        guard let Hat1 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat2 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat3 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat4 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat5 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat6= donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat7 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat8 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat9 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //
    //    //        guard let Hat10 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat11 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //    //
    //    //        guard let Hat12 = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //    //        hatRoot = HatRoot
    //    //        hatRoot.isHidden = false
    //
    //    let wrapperNode = SCNNode()
    //
    //    for child in donutsScene.rootNode.childNodes {
    //    wrapperNode.addChildNode(child)
    //    }
    //    contentRootNode.addChildNode(wrapperNode)
    //    //        contentRootNode.rotation = SCNVector4Make(0, 0, 0, 0)
    //    self.rootNode.addChildNode(contentRootNode)
    //
    //}
    //
    //    func downloadSetPg3(){
    //
    //        //test How Many MB Can Be Downloaded & not Shown At Once
    //        DownloadHelper.shared.downlaodSCN(scnName: scnName, scnRef: scnReferencePage1)
    //
    //        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    //        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
    //        let targetUrl = tempDirectory.appendingPathComponent(scnName)
    //
    //        print(targetUrl.pathExtension)
    //        print(targetUrl.absoluteURL)
    //        print(targetUrl.absoluteString)
    //
    //        var sceneForNode: SCNScene? = nil
    //        do {
    //            // load the 3D-Model node from directory path
    //            sceneForNode = try SCNScene(url: targetUrl, options: nil)
    //        }catch{
    //
    //            //show alert that an error occured
    //            print(error)
    //        }
    //
    //        guard let donutsScene = sceneForNode else {return}
    //
    //        guard let downloadedFish: SCNNode? = donutsScene.rootNode.childNode(withName: "polySurface1_meshId0_name_lambert1", recursively: true)  else {return}
    //
    //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        hatRoot = HatRoot
    //        hatRoot.isHidden = false
    //
    //        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        //        hatRoot = HatRoot
    //        //        hatRoot.isHidden = false
    //        //
    //        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        //        hatRoot = HatRoot
    //        //        hatRoot.isHidden = false
    //        //
    //        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        //        hatRoot = HatRoot
    //        //        hatRoot.isHidden = false
    //        //
    //        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        //        hatRoot = HatRoot
    //        //        hatRoot.isHidden = false
    //        //
    //        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        //        hatRoot = HatRoot
    //        //        hatRoot.isHidden = false
    //        //
    //        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        //        hatRoot = HatRoot
    //        //        hatRoot.isHidden = false
    //        //
    //        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        //        hatRoot = HatRoot
    //        //        hatRoot.isHidden = false
    //        //
    //        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        //        hatRoot = HatRoot
    //        //        hatRoot.isHidden = false
    //        //
    //        //        guard let HatRoot = donutsScene.rootNode.childNode(withName: self.hatRootName, recursively: true) else {return}
    //        //        hatRoot = HatRoot
    //        //        hatRoot.isHidden = false
    //
    //        let wrapperNode = SCNNode()
    //
    //        for child in donutsScene.rootNode.childNodes {
    //            wrapperNode.addChildNode(child)
    //        }
    //        contentRootNode.addChildNode(wrapperNode)
    //        //        contentRootNode.rotation = SCNVector4Make(0, 0, 0, 0)
    //        self.rootNode.addChildNode(contentRootNode)
    //
    //    }
    

    func getDonutJson(indexPath: IndexPath) {
        donutCollection.getDocuments { (snapshot, _) in
            
            let myUsers: [myDonutPage1Struct] = try! snapshot!.decoded()
            self.donuts = myUsers
            
            //            self.scnName2 = self.donuts[indexPath.row].name
            
        }
        
//        usersCollection.getDocuments { (snapshot, _) in
//
//            let myUsers: [myDonutPage1Struct] = try! snapshot!.decoded()
//            self.donuts = myUsers
//
//            //            self.scnName2 = self.donuts[indexPath.row].name
//
//        }
        
        //        usersCollection.getDocuments { (snapshot, _) in
        //
        //            let myUsers: [myDonutPage1Struct] = try! snapshot!.decoded()
        //            self.donuts = myUsers
        //
        //            //            self.scnName2 = self.donuts[indexPath.row].name
        //
        //        }
        
        //        usersCollection.getDocuments { (snapshot, _) in
        //
        //            let myUsers: [myDonutPage1Struct] = try! snapshot!.decoded()
        //            self.donuts = myUsers
        //
        //            //            self.scnName2 = self.donuts[indexPath.row].name
        //
        //        }
        
        //        usersCollection.getDocuments { (snapshot, _) in
        //
        //            let myUsers: [myDonutPage1Struct] = try! snapshot!.decoded()
        //            self.donuts = myUsers
        //
        //            //            self.scnName2 = self.donuts[indexPath.row].name
        //
        //        }
        
        
}

    
    func viewBlueHat(relativeTransform: matrix_float4x4) {
        showContentRootNode()
        //        launchAllDonuts()
        hatRoot.simdTransform = relativeTransform
        //            UnhideMenuItem()
    }
    
//    func viewPage2(relativeTransform: matrix_float4x4) {
//        showContentRootNode()
//        //        launchAllDonuts()
//        hatRoot.simdTransform = relativeTransform
//        //            UnhideMenuItem()
//    }
//
//    func viewPage3(relativeTransform: matrix_float4x4) {
//        showContentRootNode()
//        //        launchAllDonuts()
//        hatRoot.simdTransform = relativeTransform
//        //            UnhideMenuItem()
//    }
    
    //    func viewPage2(relativeTransform: matrix_float4x4) {
    //        showContentRootNode()
    //        //        launchAllDonuts()
    //        hatRoot.simdTransform = relativeTransform
    //        //            UnhideMenuItem()
    //    }
    //
    //    func viewPage3(relativeTransform: matrix_float4x4) {
    //        showContentRootNode()
    //        //        launchAllDonuts()
    //        hatRoot.simdTransform = relativeTransform
    //        //            UnhideMenuItem()
    //    }

    
    func showContentRootNode() {
        contentRootNode.isHidden = false
    }
}


