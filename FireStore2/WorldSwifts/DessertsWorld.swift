

import Foundation
import SceneKit
import ARKit
import SpriteKit
import ModelIO
import SceneKit.ModelIO
import Firebase
//import FirebaseFirestore
import FirebaseStorage
import FirebaseUI

//Add Dynamic Side Buttons To Downlaod Additional Meshes Inside View & Purge Previous. If a hidden label == strcuct or something is not hidden in world then downlaod correct group of meshes case function.
//or
//nib File Or Scrollview Or CollectionView for catagories

//if itemarray is over 10, 25, 50, 75, 100 {
//    then the positions change, the scales change and the circle changes. USE ENUM FOR ITEM QUANTITY CIRCLE SHELF SETTER
//}
//1-5 pages per catagory
//50 case functions non dynamic needed

class DessertsWorld: SCNScene, SCNPhysicsContactDelegate {
    
    var sceneForNode: SCNScene? = nil
    let backroundQueue = DispatchQueue.global(qos: .userInitiated)
    private var index: IndexPath = []
    
//    private var dessertsItemArray = [dessertsItemsJSON]()
    
    
    //Make ScenePages Into Struct
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCN").child("HatObj")
    //    }
    
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPage2").child("HatObj")
    //    }
    
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPage3").child("HatObj")
    //    }
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPage4").child("HatObj")
    //    }
    
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPagePage5").child("HatObj")
    //    }
    
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPage6").child("HatObj")
    
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCN7").child("HatObj")
    //    }
    
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPage8").child("HatObj")
    //    }
    
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPage9").child("HatObj")
    //    }
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPage10").child("HatObj")
    //    }
    
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPagePage11").child("HatObj")
    //    }
    
    //    var scnReference: StorageReference {
    //        return Storage.storage().reference().child("ObjSCNPage12").child("HatObj")
    //
    
    
    //scnDoc for main catagories, main catagory names, and scnnames
    
    var scnReferencePage1: StorageReference {
        return Storage.storage().reference().child("ObjSCN").child("Desserts.scn")
    }
    
    
    //NEED Firebase Database & Storage Array Links Between MESHS AND INDEX
    /////////////SCN World Node HELPER (Need Firebae Refactoring) ///////////
    
    var arrayNodes: [SCNNode] = [SCNNode]()
    
    let spinNodeName: String = "Spin"
    var spinNode = SCNNode()

    let spinnerNodeName: String = "Spinner1"
    var spinnerNode = SCNNode()
    let spinnerNodePosition: SCNVector3 = SCNVector3Make(0, 0, -4)
    

    //Refactor
//    let hatNodeName1: String = "Hat1"
    var hatNode1 = SCNNode()
    let hatNodePosition1: SCNVector3 = SCNVector3Make(0, 0.28, -0.30)
    
    let hatNodeName2: String = "Hat2"
    var hatNode2 = SCNNode()
    let hatNodePosition2: SCNVector3 = SCNVector3Make(0, -0.3, 0.4)
    
    let hatNodeName3: String = "Hat3"
    var hatNode3 = SCNNode()
    let hatNodePosition3: SCNVector3 = SCNVector3Make(0, -0.33, -0.3)
    
    let hatNodeName4: String = "Hat4"
    var hatNode4 = SCNNode()
    let hatNodePosition4: SCNVector3 = SCNVector3Make(0, 0, 0.07)
    
    let hatNodeName5: String = "Hat5"
    var hatNode5 = SCNNode()
    let hatNodePosition5: SCNVector3 = SCNVector3Make(0, 0.273, 0.334)
    
    let hatNodeName6: String = "Hat6"
    var hatNode6 = SCNNode()
    let hatNodePosition6: SCNVector3 = SCNVector3Make(0, 0, -0.4)
    
    let hatNodeName7: String = "Hat7"
    var hatNode7 = SCNNode()
    let hatNodePosition7: SCNVector3 = SCNVector3Make(0, 0.385, -0.021)
    
    let hatNodeName8: String = "Hat8"
    var hatNode8 = SCNNode()
    let hatNodePosition8: SCNVector3 = SCNVector3Make(0, 0, 0.478)
    
    
    ///////////// NEED SCNREFERENCE FOR SETUP, LIGHTS,TV,BOX,PLACEMENT NODES/POSITIONS/////////
    
    //Setup Nodes
    lazy var contentRootNode = SCNNode()
    lazy var dessertsRoot = SCNNode()
    lazy var dessertsCatagory = SCNNode()
    
    //Light nodes
    lazy var spotLightNode = SCNNode()
    lazy var mainLightSourceNode = SCNNode()
    
    ///////////// Televeison Nodes ///////////
    lazy var tV = SCNNode()
    lazy var tvMaterial = SCNMaterial()
    lazy var videoTVNode = SKVideoNode()
    
    var sceneForNodee: SCNScene? = nil

    var scnName: String = "Desserts.scn"
    var dessertsScn: String = " Desserts.scn"
    var dessertsName: String = "DessertsRoot"
    
    
    ///////////// View Item Position ///////////
    let viewSpotNodePosition: SCNVector3 = SCNVector3Make(0.13, 0.00, -0.3)
    
    let worldFinishedLoading: Bool = false
    
    /////////////SpotLight & TV Name HELPER ///////////
    let spotLightName: String = "SpotLight"
    let spotLightName2: String = "SpotLight2"
    let tvName: String = "TV"
    let ambiantName: String = "Ambiant"
    
    ///////////// Load Scene Onto MainUI HELPER ///////////
    override init() {
        super.init()
        //Learn to Make UI Image Firebase Storage
//        self.lightingEnvironment.contents = UIImage(named: "art.scnassets/environment_blur.exr")
        self.lightingEnvironment.intensity = 2.0
        getDessertsJson(indexPath: index)
        //Load Tap Catagory Scene!
        loadDessertsWorld()
        //                loadMaterials()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    deinit {
        print("Sides Officially Removed Biiiiitches")
        //Clear From Temp Directory Cache Func
    }
    
    
    //Make Singleton shared
   
    private func saveImageToTmpFolder(image: UIImage, withName: String) {
        
        if let data = image.pngData() {
            
            let tempDirectory = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
            //                let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Q'sDirectory")
            
            let targetURL = tempDirectory.appendingPathComponent("\(String(describing: uname)).jpg")
            do{
                try data.write(to: targetURL)
            } catch {
                print("We Fucked Up Something")
            }
        }
    }
    
    
    func loadDessertsWorld() {
        
        //Get Downloaded Scene
        //        guard let virtualWorldSceneFR = sceneForNode else {return}

        //Get Correct Folder & SCN Names From WorldJSON GENERIC CODE
//        guard let sceneForNode = SCNScene(named: dessertsScn, inDirectory: scnFolderName) else {return} 
        
        DownloadHelper.shared.downlaodSCN(scnName: "Desserts.scn", scnRef: scnReferencePage1)
        
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
        
//        guard let hat1 = virtualWorldScene.rootNode.childNode(withName: hatNodeJson.hatNodeName1, recursively: true) else {return}
//        hatNode1 = hat1

        guard let hat2 = sceneForNode?.rootNode.childNode(withName: hatNodeName2, recursively: true) else {return}
        hatNode2 = hat2

        guard let hat3 = sceneForNode?.rootNode.childNode(withName: hatNodeName3, recursively: true) else {return}
        hatNode3 = hat3

        guard let hat4 = sceneForNode?.rootNode.childNode(withName: hatNodeName4, recursively: true) else {return}
        hatNode4 = hat4

        guard let hat5 = sceneForNode?.rootNode.childNode(withName: hatNodeName5, recursively: true) else {return}
        hatNode5 = hat5

        guard let hat6 = sceneForNode?.rootNode.childNode(withName: hatNodeName6, recursively: true) else {return}
        hatNode6 = hat6
        
        guard let hat7 = sceneForNode?.rootNode.childNode(withName: hatNodeName7, recursively: true) else {return}
        hatNode7 = hat7
        
        guard let hat8 = sceneForNode?.rootNode.childNode(withName: hatNodeName8, recursively: true) else {return}
        hatNode8 = hat8
//
//        guard let hat5 = virtualWorldScene.rootNode.childNode(withName: hatNodeName5, recursively: true) else {return}
//        hatNode5 = hat5
//
//        guard let hat6 = virtualWorldScene.rootNode.childNode(withName: hatNodeName6, recursively: true) else {return}
//        hatNode6 = hat6
//
//        guard let hat7 = virtualWorldScene.rootNode.childNode(withName: hatNodeName7, recursively: true) else {return}
//        hatNode7 = hat7
//
//        guard let hat8 = virtualWorldScene.rootNode.childNode(withName: hatNodeName8, recursively: true) else {return}
//        hatNode8 = hat8

        //Standard World Setup Nodes GENERIC CODE
        guard let DessertsRoot = sceneForNode?.rootNode.childNode(withName: "DessertsRoot", recursively: true) else {return}
        dessertsRoot = DessertsRoot
        
        guard let DessertsCatagory = sceneForNode?.rootNode.childNode(withName: "DessertsCatagory", recursively: true) else {return}
        dessertsCatagory = DessertsCatagory
        
        guard let Spinner1 = sceneForNode?.rootNode.childNode(withName: spinnerNodeName, recursively: true) else {return}
        spinnerNode = Spinner1
        guard let Spinner = sceneForNode?.rootNode.childNode(withName: spinNodeName, recursively: true) else {return}
        spinNode = Spinner
        
        ///////////// World Light Set Nodes HELPER ///////////
        guard let spotLightt = sceneForNode?.rootNode.childNode(withName: spotLightName, recursively: true) else {return}
        spotLightNode = spotLightt
        let spotlight = SCNLight()
        
        spotlight.type = .spot
        spotlight.spotInnerAngle = 6
        spotlight.spotOuterAngle = 8
        spotlight.intensity = 30
        spotLightNode.light = spotlight
        
        
        guard let mainAmbiant = sceneForNode?.rootNode.childNode(withName: ambiantName, recursively: true) else {return}
        mainLightSourceNode = mainAmbiant
        
        let mainAmbientLight = SCNLight()
        mainAmbientLight.type = .ambient
        mainAmbientLight.intensity = 750
        mainLightSourceNode.light = mainAmbientLight
        
        guard let TV = sceneForNode?.rootNode.childNode(withName: tvName, recursively: true) else {return}
        tV = TV
        
//        //Refactor To Pull From Documents or TMP Directory
//        guard let url2 = Bundle.main.url(forResource: "cake", withExtension: "obj") else {
//            fatalError("Failed to find model file.")
//        }
//
//
//        //Refactor Into Function
//        let asset2 = MDLAsset(url:url2)
//        guard let object2 = asset2.object(at: 0) as? MDLMesh else {
//            fatalError("Failed to get mesh from asset.")
//        }
//
//        let scatteringFunction2 = MDLPhysicallyPlausibleScatteringFunction()
//        let material2 = MDLMaterial(name: "baseMaterial", scatteringFunction: scatteringFunction2)
//
//
//        //      NEED TO GET IMAGES OUT OF TMP DIRECTORY OR CALL FROM FIREBASE STORAGE
//        //
//        material2.setTextureProperties([
//            .baseColor:"cake.jpg"])
//
//        for  submesh2 in object2.submeshes!  {
//            if let submesh2 = submesh2 as? MDLSubmesh {
//                submesh2.material = material2
//            }
//        }
//        let cakeObj = SCNNode(mdlObject: object2)
//        //        node2.name = node2Name
//        cakeObj.scale = SCNVector3Make(1, 1, 1)
//        cakeObj.rotation = SCNVector4Make(0, 0, 0, 0)
//
//        self.testObjectNode?.addChildNode(cakeObj)

        
        ///////////// Set All Nodes HELPER ///////////
        let wrapperNode = SCNNode()
        for child in (sceneForNode?.rootNode.childNodes)! {
            wrapperNode.addChildNode(child)
        }
        self.rootNode.addChildNode(self.contentRootNode)
        self.contentRootNode.addChildNode(wrapperNode)
        //        worldFinishedLoading = true
        
        //Replace With Filter. Every Child That Already Got Added
        for child in (sceneForNode?.rootNode.childNodes)! {
            arrayNodes.append(child)
        }
    }
    

    // DOWNLOAD DATABASE & STORAGR (TURN TO SINGLETON CLASS SHARED STATIC FUNC!
    func getDessertsJson(indexPath: IndexPath) {
        //                usersCollection.getDocuments { (snapshot, _) in
        //
        //
        //                    let myUsers: [hatItemArray] = try! snapshot!.decoded()
        //                    hatItemArray = myUsers
        //
        //
        //                    DispatchQueue.main.async {
        //                        self.collectionView.reloadData()
        //                    self.downloadIndicator.isHidden = true
        //                        self.downloadGIF.isHidden = true
        //                        self.downloadGIF.stopAnimating()
        //                    }
        //                }
    }
    
    
    func rotateAllItems() {
        spinnerNode.rotate3(floatn: -7, floatn2: 0, Floatin3: 0, durationn: 30)
    }
    
    func stopRotatingAllItems() {
        spinnerNode.stopSpinActions()
    }
    
    func checkIfSpinning() {
        if spinNode.isHidden == false {
            stopRotatingAllItems()
            hatNode7.spinX()
            spinNode.isHidden = true
        }
        else {
            rotateAllItems()
            hatNode7.stopSpinActions()
            spinNode.isHidden = false
            print("Bitch")
            return
        }
    }
    
    func arrayFunction() {
        
    }
    
    func removeWorld() {
        contentRootNode.cleanupMeshes()
        contentRootNode.removeFromParentNode()
    }
    
    func removeMeshesFromMemoryRestartButtonButton() {
        rootNode.cleanupMeshes()
    }
    
    //get closest node from main GENERIC CODE
    func viewItemDirectly(relativeTransform: matrix_float4x4) {
        dessertsRoot.simdTransform = relativeTransform
        showContentRootNode()
        UnhideMenuItem()
        //        showContentRootNode()
        //        resetOpacity()
        //        fadeInItems()
    }
    
    //RESET ALL ITEMS or put all children at beginning node?
//    func resetAllNodes() {
//        startSpinTap(withImageName: hatNodeName8)
//    }
    
    func resetRootPosition() {
        let startingPosition = SCNVector3(0, 0, 0)
        contentRootNode.position = startingPosition
    }
    
    func showContentRootNode() {
        contentRootNode.isHidden = false
    }
    
    func hideContentRootNode() {
        contentRootNode.isHidden = true
    }
    
    func UnhideMenuItem() {
        hatNode8.isHidden = false
    }
    
    func fadeInItems() {
        hatNode8.fadeItem()
    }
    
    func resetOpacity() {
        hatNode8.opacity = 0.0
    }
    
    func show() {
        contentRootNode.isHidden = false
    }
    
    func hide() {
        contentRootNode.isHidden = true
    }
    
    func isVisible() -> Bool {
        return !contentRootNode.isHidden
    }
    
    func setTransform(_ transform: simd_float4x4) {
        contentRootNode.simdTransform = transform
    }
    
    func createSCNURL(scnName: String) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
        let targetUrl = tempDirectory.appendingPathComponent(scnName)
        return targetUrl
    }
    
    
//    class DownloadHelper {
//
//        private init() {}
//        static let shared = DownloadHelper()
//
//        var scnName: String?
//        var donutsScene: String?
//        //    var drinksScene: String = self.donuts[index.row].name
//        var scnFolderName: String?
//
//        func downlaodSCN(scnName: String, scnRef: StorageReference){
//            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//            let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
//            let targetUrl = tempDirectory.appendingPathComponent(scnName)
//
//            //check if already exists Help
//
//            //        do try cache
//            scnRef.write(toFile: targetUrl) { (url, error) in
//                if error != nil {
//                    print("ERROR: \(error!)")
//                }else{
//                    print("modelPath.write OKAY")
//                }
//
//                //make sure to write correct name or use medatata name inside load fucntion
//            }
//
//            scnRef.getMetadata { (metaData, error) in
//                if error != nil {
//                    print("ERROR: ", error!)
//                }else{
//                    print("Metadata: \(metaData!)")
//                }
//            }
//
//
//        }

    
//    if world cannot be found like opage out iof index then revert to somting
}
