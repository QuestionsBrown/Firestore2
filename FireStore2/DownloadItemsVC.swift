//
//  DownloadObjViewController.swift
//  FireStore2
//
//  Created by Concetta Turner on 1/3/19.
//  Copyright © 2019 Concetta Turner. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Firebase
import FirebaseUI



//MainscreenStart
//Per Main Catagory?
class ARVC: UIViewController, ARSCNViewDelegate {
    
    //Refactor Dynamic ScenePages Placing
    
    //Need to set this dynamically inside main view in order to dynamiccaly have all (Scnscenes) ScenePages created with protocols
    var foodWorld = HatsWorld()
    var dessertsWorld = DessertsWorld()
    

    lazy var usersCollection = Firestore.firestore().collection("donuts")
    
    //catagory UX Labels, catagory titles as text!, main view images
    var topARLabel: DocumentReference {
        return usersCollection.document("ipjLFMuwmcbnEzFxhOq1TastesLikeASamoa")
    }
    
    var catagoryLabel: DocumentReference {
        return usersCollection.document("ipjLFMuwmcbnEzFxhOq1TastesLikeASamoa")
    }
    
    
    var descriptionBitch: String!


    //    var name: String!

    //    var descritpionImage: UIImage!

    //Manually Make SceneView Variable With Constraints
    
    @IBOutlet var mainScreen: UIView!
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet weak var titleHelper: UILabel!
    
    @IBOutlet weak var titleHelperButton: UIButton!
    
    
    func resetTrackingConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
    }
    
    override func viewDidLoad() {
        
        mainScreen.alpha = 0.0
        
        startNewSession()
        //if title = catagory name do switch statement choose which to load after 4 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                   self.setdessertsScene()
            self.dessertsWorld.viewItemDirectly(relativeTransform: (self.sceneView.session.currentFrame?.camera.transform)!)
            return
        }

        setupPBRHDRCamera()
//          titleHelperButton.titleLabel?.text = descriptionBitch
//        getDonutDocJson()
        
//        if title from segue is case whatever, preset page
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)) {
        self.setStartScreen()
            self.foodWorld.viewBlueHat(relativeTransform: (self.sceneView.session.currentFrame?.camera.transform)!)
            return
        }
        
        titleHelper.text = descriptionBitch
        super.viewDidLoad()
        
    }
    
    
    //Change Catagory Label
    func getDonutDocJson() {
        topARLabel.getDocument { (snapshot, _) in

            guard let snapshot = snapshot, snapshot.exists else {return}
            let data = snapshot.data()
            DispatchQueue.main.async {
                let description1 = data?["description"] as? String ?? ""
                let name1 = data?["name"] as? String ?? ""
                //            let description1 = data?["description"] as? String ?? ""
                //            let name1 = data?["name"] as? String ?? ""
                self.titleHelperButton.titleLabel?.text = data?["description"] as? String ?? ""
               self.titleHelper.text = data?["description"] as? String ?? ""}
//                        vc.navigationbartitle.text = name1

        }
    }
    
    func getSecondCatagory() {
        topARLabel.getDocument { (snapshot, _) in
            
            guard let snapshot = snapshot, snapshot.exists else {return}
            let data = snapshot.data()
            DispatchQueue.main.async {
                let description1 = data?["description"] as? String ?? ""
                let name1 = data?["name"] as? String ?? ""
                //            let description1 = data?["description"] as? String ?? ""
                //            let name1 = data?["name"] as? String ?? ""
                self.titleHelperButton.titleLabel?.text = data?["description"] as? String ?? ""
                self.titleHelper.text = data?["description"] as? String ?? ""}
            //                        vc.navigationbartitle.text = name1
            
        }
    }
    
    
    //Per 12
    func setStartScreen() {
        sceneView?.delegate = self
        sceneView?.antialiasingMode = .multisampling4X
        //removeAllWorlds
        sceneView?.scene = foodWorld
        sceneView?.automaticallyUpdatesLighting = false
        sceneView?.autoenablesDefaultLighting = false
        sceneView?.showsStatistics = false
//        foodWorld.viewCatagoryAllItems(relativeTransform: (self.sceneView.session.currentFrame?.camera.transform)!)

    }
    
    func setdessertsScene() {
        sceneView?.delegate = self
        sceneView?.antialiasingMode = .multisampling4X
        //removeAllWorlds
        sceneView?.scene = dessertsWorld
        sceneView?.automaticallyUpdatesLighting = false
        sceneView?.autoenablesDefaultLighting = false
        sceneView?.showsStatistics = false
        //        foodWorld.viewCatagoryAllItems(relativeTransform: (self.sceneView.session.currentFrame?.camera.transform)!)
        
    }
    
    
    @IBAction func launchPage1(_ sender: Any) {
        
//        foodWorld.viewBlueHat(relativeTransform: (sceneView.session.currentFrame?.camera.transform)!)
    }
    
    
    func startNewSession() {
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        if #available(iOS 11.3, *) {
            configuration.isAutoFocusEnabled = true
        } else {
        }
        configuration.detectionImages = referenceImages
        sceneView?.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
    
    
    func startARImageRef(){
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
    }
    
    func setupPBRHDRCamera() {
        guard let camera = sceneView?.pointOfView?.camera else {
            fatalError("Expected a valid `pointOfView` from the scene.")
        }
        camera.wantsHDR = true
        camera.exposureOffset = -0.2
        camera.minimumExposure = -1
        camera.maximumExposure = 0
        camera.screenSpaceAmbientOcclusionIntensity = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard ARWorldTrackingConfiguration.isSupported else {
            fatalError("""
                ARKit is not available on this device. For apps that require ARKit
                for core functionality, use the `arkit` key in the key in the
                `UIRequiredDeviceCapabilities` section of the Info.plist to prevent
                the app from installing. (If the app can't be installed, this error
                can't be triggered in a production scenario.)
                In apps where AR is an additive feature, use `isSupported` to
                determine whether to show UI for launching AR experiences.
            """) // For details, see https://developer.apple.com/documentation/arkit
        }
        
        
        // Prevent the screen from being dimmed after a while.
        UIApplication.shared.isIdleTimerDisabled = true
        
        
        if self.mainScreen.alpha == 0.0 {
            
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations:
                {
                    self.mainScreen.alpha = 1.0
            })
        } else {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations:
                {
                    self.mainScreen.alpha = 0.0
            })
        }
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 3.87) { // change 2 to desired number of seconds
        //            UIView.animate(withDuration: 3.4) {
        //                self.label.center.x += self.view.bounds.width
        //            }
        //        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
        
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        //        if hatWorld.isVisible() { return }
        
        // Unhide the content and position it on the detected plane
        if anchor is ARPlaneAnchor {
            //            hatWorld.setTransform(anchor.transform)
            //            world.show()
            
            DispatchQueue.main.async {
                //                self.hideToast()
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didApplyConstraintsAtTime time: TimeInterval) {
    }
}
    
//    func createSCNURL(scnName: String) -> URL {
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
//        let targetUrl = tempDirectory.appendingPathComponent(scnName)
//        return targetUrl
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        //        if hatWorld.isVisible() { return }
//
//        // Unhide the content and position it on the detected plane
//        if anchor is ARPlaneAnchor {
//            //            hatWorld.setTransform(anchor.transform)
//            //            world.show()
//
//            DispatchQueue.main.async {
//                //                self.hideToast()
//            }
//        }
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didApplyConstraintsAtTime time: TimeInterval) {
//    }
    

//    
//    func loadFirstArtist() {
//        //        let configuration = ARWorldTrackingConfiguration()
//        //1. Get The Image From The Folder
//        
//        
//        let configuration = ARWorldTrackingConfiguration()
//        
//        
//        //KNOW HOW MANY ARTIST, SONGS IMAGES YOU NEED
//        let mambaImage2: UIImage = {
//            let mambaImage = UIImageView()
//            let kobeImage = mambaImage.image
//            //            let kobeImage = self.mambaImage2.image!
//            return kobeImage!
//        }()
//        
//        //Download Images From Firebase Into UIImage
//        
//        guard let imageToCIImage2 = CIImage(image: mambaImage2),
//            let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage2) else { return }
//        let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.508)
//        
//        arImage.name = "Mamba"
//        
//        //        //1. Get The Image From The Folder (Refactor) Set Downloaded image to dummy image
//        //        guard let imageFromBundle = UIImage(named: "Mamba"),
//        //            //2. Convert It To A CIImage
//        //            let imageToCIImage = CIImage(image: imageFromBundle),
//        //            //3. Then Convert The CIImage To A CGImage
//        //            let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage)else { return }
//        //        //4. Create An ARReference Image (Remembering Physical Width Is In Metres)
//        //        let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.508)
//        //        //5. Name The Image
//        //        arImage.name = "Mamba"
//        
//        //1. Get The Image From The Folder
//        guard let image2FromBundle = UIImage(named: "Disney"),
//            //2. Convert It To A CIImage
//            let image2ToCIImage = CIImage(image: image2FromBundle),
//            //3. Then Convert The CIImage To A CGImage
//            let cg2Image = convertCIImageToCGImage(inputImage: image2ToCIImage)else { return }
//        //4. Create An ARReference Image (Remembering Physical Width Is In Metres)
//        let ar2Image = ARReferenceImage(cg2Image, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.508)
//        //5. Name The Image
//        ar2Image.name = "Disney"
//        
//        //6. Set The ARWorldTrackingConfiguration Detection Images!!!!!!!!!!!!!!!!!
//        configuration.detectionImages = [arImage, ar2Image]
//        
//        //        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "myFolder", bundle: nil) else { return }
//        
//        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
//        sceneView.session.run(configuration, options: options)
//    }
//    
//    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
//        let context = CIContext(options: nil)
//        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
//            return cgImage
//        }
//        return nil
//    }
//}
