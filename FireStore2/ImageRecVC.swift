//
//  ImageRec.swift
//  FireStore2
//
//  Created by Concetta Turner on 4/5/19.
//  Copyright © 2019 Concetta Turner. All rights reserved.
//

import UIKit
import ARKit
import AVFoundation
import AVKit
import StoreKit
import MediaPlayer
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseUI


class ImageRecViewController: UIViewController, SKStoreProductViewControllerDelegate {
    
    public var realGuideNode = SCNNode()
    public var clearGuide = SCNNode()
    var mambaImage = UIImage(named: "Mamba")
    let kellogsImage = UIImage(named: "Kellogs")
    
    var player: AVPlayer?
    let membersLink = "https://www.vmfa.museum/membership/"
    let donateLink = "https://www.vmfa.museum/support/ways-to-give/vmfa-annual-fund/"
    let gayManVid = "https://www.youtube.com/watch?v=5pwkZh8Ljug&t=57s"
    
    
    var imageRecPhoto: StorageReference {
        return Storage.storage().reference().child("recImages").child("IMG_5438.jpg")
    }
    
    
    @IBOutlet var mainScreen: UIView!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var label: UILabel!
    
//    @IBOutlet weak var toolBar: UIToolbar!
    let fadeDuration: TimeInterval = 0.3
    let rotateDuration: TimeInterval = 3
    let waitDuration: TimeInterval = 0.5
    
    
    lazy var fadeAndSpinAction: SCNAction = {
        return .sequence([
            .fadeIn(duration: fadeDuration),
            //            .rotateBy(x: 0, y: 0, z: CGFloat.pi * 360 / 180, duration: rotateDuration),
            //            .wait(duration: waitDuration),
            //            .fadeOut(duration: fadeDuration)
            ])
    }()


        

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        configureLighting()
        mainScreen.alpha = 0.0
//        sceneView.pointOfView?.addChildNode(clearGuide)
        loadFirstArtistIOS()
//        loadfirstartistFB()
//         DownloadHelper.shared.downloadImages(imageName: "We Found Wiz", imageRef: imageRecPhoto)
        
    
 
       
    }
    
    //    lazy var fadeAction: SCNAction = {
    //        return .sequence([
    //            .fadeOpacity(by: 0.8, duration: fadeDuration),
    //            .wait(duration: waitDuration),
    //            .fadeOut(duration: fadeDuration)
    //            ])
    //    }()
    
    //Static struct for placement nodes for scnreferences
    //    lazy var fakeGuideNode: SCNNode = {
    //        guard let scene = SCNScene(named: "tree.scn"),
    //            let fakeGuidenodeNode = scene.rootNode.childNode(withName: "nil", recursively: false) else { return SCNNode() }
    //        return fakeGuidenodeNode
    //    }()
    //
    //
    //
    //
    //    lazy var fakeClearzguidNode: SCNNode = {
    //        guard let scene = SCNScene(named: "tree.scn"),
    //            let node = scene.rootNode.childNode(withName: "clearGuide", recursively: false) else { return SCNNode() }
    //            let realGuideNode = scene.rootNode.childNode(withName: "realGuide", recursively: false)
    //
    //        node.opacity = 0.5
    //        realGuideNode?.opacity = 1
    //        node.position = SCNVector3(0, -0.2, 0)
    //        node.eulerAngles.x = 0
    //        node.eulerAngles.y = 0
    //        node.eulerAngles.z = 0
    //        return node
    //    }()
    
    
    //loadfirstimages
    func loadFirstArtistIOS() {
        //
        var imageDownloaded = UIImage()
        
        DownloadHelper.shared.loadImageAsync(imageName: "Mamba") { DLIMAGE, error in
            
            
            imageDownloaded = DLIMAGE!
            
            
            let configuration = ARWorldTrackingConfiguration()
            guard let imageToCIImage2 = CIImage(image: imageDownloaded),
                let cgImage = self.convertCIImageToCGImage(inputImage: imageToCIImage2) else { return }
            let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.508)
            arImage.name = "Mamba"
            
            
            
            configuration.detectionImages = [arImage]
            let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
            self.sceneView.session.run(configuration, options: options)
            self.label.text = "Scan Posters"
            
        }
        
    }
    
//    func loadfirstartistFB() {
//
//        var imageDownloaded = UIImage()
//
//        DownloadHelper.shared.loadImageFB(imageName: "Mamba", imageRef: imageRecPhoto) { DLIMAGE, error in
//
//            do {
//                let imageDownloaded = try? DLIMAGE
//
//            } catch {
//                print("Well We Tried")
//            }
//
//            let configuration = ARWorldTrackingConfiguration()
//            guard let imageToCIImage2 = CIImage(image: imageDownloaded),
//                let cgImage = self.convertCIImageToCGImage(inputImage: imageToCIImage2) else { return }
//            let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.508)
//            arImage.name = "Mamba"
//
//
//
//            configuration.detectionImages = [arImage]
//            let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
//            self.sceneView.session.run(configuration, options: options)
//            self.label.text = "Scan Posters"
//
//        }
//    }
    
    //        func getNode(withImageName name: String) -> SCNNode
    func getNode(withImageName name: String) -> SCNNode {
        
        var node = SCNNode()
        
//        let sceneView = SCNScene(named: "ship", inDirectory: "art.scnassets")
//
//        //Get Correct Node Name From WorldJSON
//        let containerNode = sceneView!.rootNode.childNode(withName: "container", recursively: true)
//        clearGuide = containerNode!
        
        switch name{
            
        case "Mamba" :
//            sceneView.pointOfView?.addChildNode(clearGuide)
//            sceneView.pointOfView?.childNode(withName: "clearGuide", recursively: true)?.removeFromParentNode()
            
            let url = URL(string: "https://k003.kiwi6.com/hotlink/r16tj49ild/Diego_Money_and_Famous_Dex_-_Goyard4k_Prod._UglyFriend_.mp3")
            self.playUsingAVPlayer(url: url!)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //            if let url = URL(string: "https://www.customink.com/ink/psr/custom-t-shirts?pc=PNG-1130648576Z&cm_ite=shirt_design_maker_online&adpos=1t1&creative=231105288660&device=c&matchtype=b&network=g&mrkgcl=293&mrkgadid=1130648576&gclid=Cj0KCQjwgMnYBRDRARIsANC2dfnuDBHQy_6O-mRETvtiGFqwX63fnaJL3v6UpY5afUr7bPAQq7IVd3EaAtrEEALw_wcB") {
                //                UIApplication.shared.open(url, options: [:])
                //            }
            }
            node = clearGuide
            
        case "Mama Card" :
            
            
            //refactor links
            if let url = URL(string: "https://www.youtube.com/watch?v=MdQW4Cw0yVw") {
                UIApplication.shared.open(url, options: [:])
            }
        //            node = fakeGuideNode
        case "nun" :
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.87) {
                //                App Links and Youtube Links and Website Links Soundcloud Links
                //                            if let url = URL(string: "https://itunes.apple.com/us/album/o-n-i-f-c-deluxe-version/562648250?app=music&ign-mpt=uo%3D4") {
                //                                UIApplication.shared.open(url, options: [:])
                //
                //                            }
                
                
                //get URL from database
                let url = URL(string: "https://k003.kiwi6.com/hotlink/r16tj49ild/Diego_Money_and_Famous_Dex_-_Goyard4k_Prod._UglyFriend_.mp3")
                self.playUsingAVPlayer(url: url!)
                
            }
            //AppStore Links
            //            openStoreProductWithiTunesItemIdentifier(identifier: "http://appstore.com/gameloft")
            //            node = fakeGuideNode
            
        default:
            break
        }
        return node
    }
    
    
    //    let panObj = UIPanGestureRecognizer(target: self, action: #selector(panObjs(rec:)))
    //    sceneView.addGestureRecognizer(panObj)
    
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
    
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        toolBar.center.x -= mainScreen.bounds.width
        label.center.x -= mainScreen.bounds.width
        resetTrackingConfiguration()    
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.mainScreen.alpha == 1.0 {
            
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations:
                {
                    self.mainScreen.alpha = 0.0
            })
        } else {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations:
                {
                    self.mainScreen.alpha = 1.0
            })
        }
        sceneView.session.pause()
    }
    
    
    
    
    @IBAction func resetButtonDidTouch(_ sender: UIBarButtonItem) {
        
        player?.pause()
        player?.isMuted = true
        //        player?.seek(to: kCMTimeZero)
        //        player?.play()
        
    
        self.sceneView.scene.rootNode.enumerateChildNodes { (existingNode, _) in
            
            existingNode.removeFromParentNode()
        }
//        loadFirstArtist()
        //        loadFirstArtist2()
        //        loadFirstArtist3()
        //        loadFirstArtistr4()
        resetTrackingConfiguration()
        player?.isMuted = true
        
    }
    
    
    @IBAction func playButton(_ sender: UIButton) {
        
        player?.play()
    }
    @IBAction func pauseButton(_ sender: UIButton) {
        
        player?.pause()
    }
    func playUsingAVPlayer(url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            player = AVPlayer(url: url)
            player?.play()
        } catch {
            print(error)
        }
    }
    
    //    func restartFromBeginning(url: URL) {
    //        player = AVPlayer(url: url)
    //
    //
    //        if player.isPlaying
    //        {
    //            player.pause()
    //        }
    //
    //        player.currentTime = 0
    //        player.play()
    //    }
    

  
            

        
        

//     (config: ARConfiguration, arrayOfImages: [UIImage], myUIimage: UIImage)
        
        //        //1. Get The Image From The Folder (Refactor) Set Downloaded image to dummy image
        //        guard let imageFromBundle = UIImage(named: "Mamba"),
        //            //2. Convert It To A CIImage
        //            let imageToCIImage = CIImage(image: imageFromBundle),
        //            //3. Then Convert The CIImage To A CGImage
        //            let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage)else { return }
        //        //4. Create An ARReference Image (Remembering Physical Width Is In Metres)
        //        let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.508)
        //        //5. Name The Image
        //        arImage.name = "Mamba"
        
        //1. Get The Image From The Folder
//        guard let image2FromBundle = UIImage(named: "Disney"),
//            //2. Convert It To A CIImage
//            let image2ToCIImage = CIImage(image: image2FromBundle),
//            //3. Then Convert The CIImage To A CGImage
//            let cg2Image = convertCIImageToCGImage(inputImage: image2ToCIImage)else { return }
//        //4. Create An ARReference Image (Remembering Physical Width Is In Metres)
//        let ar2Image = ARReferenceImage(cg2Image, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.508)
//        //5. Name The Image
//        ar2Image.name = "Disney"
        
        //6. Set The ARWorldTrackingConfiguration Detection Images!!!!!!!!!!!!!!!!!

        //        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "myFolder", bundle: nil) else { return }
        
   

    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        return nil
    }
    
    //    func loadSsecondArtist(){
    //
    //        //        resetTrackingConfiguration()
    //        let configuration = ARWorldTrackingConfiguration()
    //
    //        //1. Get The Image From The Folder
    //        //Download Images From Firebase Into UIImage
    //
    //        guard let imageFromBundle = mambaImage,
    //            //2. Convert It To A CIImage
    //            let imageToCIImage = CIImage(image: imageFromBundle),
    //            //3. Then Convert The CIImage To A CGImage
    //            let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage)else { return }
    //
    //        //4. Create An ARReference Image (Remembering Physical Width Is In Metres)
    //        let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.508)
    //
    //        //5. Name The Image
    //        arImage.name = "Mamba"
    //
    //        configuration.detectionImages = [arImage]
    //
    //    }
    //
    //    //iBecaon Monitor Region Launch This
    //    func loadThirdArtist(){
    //        //                    resetTrackingConfiguration()
    //        let configuration = ARWorldTrackingConfiguration()
    //        //1. Get The Image From The Folder
    //        guard let image2FromBundle = kellogsImage,
    //            //2. Convert It To A CIImage
    //            let image2ToCIImage = CIImage(image: image2FromBundle),
    //            //3. Then Convert The CIImage To A CGImage
    //            let cg2Image = convertCIImageToCGImage(inputImage: image2ToCIImage)else { return }
    //
    //        //4. Create An ARReference Image (Remembering Physical Width Is In Metres)
    //        let ar2Image = ARReferenceImage(cg2Image, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.24765)
    //
    //        //5. Name The Image
    //        ar2Image.name = "Disney"
    //
    //        //5. Set The ARWorldTrackingConfiguration Detection Images
    //        configuration.detectionImages = [ar2Image]
    //    }
    
    
    func resetTrackingConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
        label.text = "Scan Posters"
    }
    
    
    //reetTracking2
    
    func resetTrackingConfiguration2() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "2nd Artist", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
        label.text = "Scan Posters"
    }
    
}

extension ImageRecViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            
            self.sceneView.scene.rootNode.isHidden = false
            
            guard anchor is ARImageAnchor else { return }
            
         
            
            guard let imageAnchor = anchor as? ARImageAnchor,
                let imageName = imageAnchor.referenceImage.name else { return }
            
            let x = imageAnchor.transform
            print(x.columns.3.x, x.columns.3.y , x.columns.3.z)
            
            //2. Get The Targets Name
            let name = imageAnchor.referenceImage.name!
            
            //3. Get The Targets Width & Height In Meters
            let width = imageAnchor.referenceImage.physicalSize.width
            let height = imageAnchor.referenceImage.physicalSize.height
            
            print("""
                Image Name = \(name)
                Image Width = \(width)
                Image Height = \(height)
                """)
            
            let planeNode = self.getPlaneNode(withReferenceImage: imageAnchor.referenceImage)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.blue
            planeNode.opacity = 1.0
            planeNode.eulerAngles.x = -.pi / 2
            //                        planeNode.runAction(self.fadeAction)
            
            node.addChildNode(planeNode)
            
            // TODO: Overlay 3D Object
            let overlayNode = self.getNode(withImageName: imageName)
            overlayNode.opacity = 0
            overlayNode.position.y = 0.2
            overlayNode.runAction(self.fadeAndSpinAction)
            node.addChildNode(overlayNode)
            
            self.label.font = UIFont(name: "Optima", size: 19)
            self.label.text = (imageName)
            self.label.numberOfLines = 10
            
            
            //use scnreferences letters, 
            
            
            
  
            
        }
    }
    
    func getPlaneNode(withReferenceImage image: ARReferenceImage) -> SCNNode {
        
//        guard let container = self.sceneView.scene.rootNode.childNode(withName: "container", recursively: false) else { return }
//
//        guard let video = container.childNode(withName: "video", recursively: true) else { return }
//
//        // Animations
//        guard let videoContainer = container.childNode(withName: "videoContainer", recursively: false) else { return }
//        guard let text = container.childNode(withName: "text", recursively: false) else { return }
//        guard let textTwitter = container.childNode(withName: "textTwitter", recursively: false) else { return }
        
        
        let plane = SCNPlane(width: image.physicalSize.width,
                             height: image.physicalSize.height)
        let node = SCNNode(geometry: plane)
        
        node.rotation = SCNVector4(0,0,0,0)
        
        //streamVideoRefactor()
        let videoNode = SKVideoNode(fileNamed: "video.mp4")
        let skScene = SKScene(size: CGSize(width: 640, height: 480))
        //Unhide All TVs
        sceneView.scene.rootNode.isHidden = false
        
        skScene.addChild(videoNode)
        videoNode.position = CGPoint(x: skScene.size.width/2, y: skScene.size.height/2)
        videoNode.size = skScene.size
        videoNode.zRotation = CGFloat(-Double.pi) * 90 / 180
//        videoNode.size.width = self.frame.size.height
//        videoNode.size.height = self.frame.size.width
        videoNode.yScale = -1
        plane.firstMaterial?.diffuse.contents = skScene
        videoNode.play()
        return node
    }

    
}

//extension UIView {
//
//    func animateButtonDown() {
//
//        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseIn], animations: {
//            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//        }, completion: nil)
//    }
//
//    func animateButtonUp() {
//
//        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseOut], animations: {
//            self.transform = CGAffineTransform.identity
//        }, completion: nil)
//}
//}



//
//    @objc func panObjs(rec: UIPanGestureRecognizer){
//
//        let translation = rec.translation(in: rec.view)
//
//        let x = Float(translation.x)
//        let y = Float(-translation.y)
//        let anglePan = (sqrt(pow(x,2)+pow(y,2)))*(Float)(Double.pi) / -180.0
//
//        var rotationVector = SCNVector4()
//        rotationVector.x = x
//        rotationVector.y = y
//        rotationVector.z = 0.0
//        rotationVector.w = anglePan
////
////        for child in chameleon.contentRootNode.childNodes {
////            child.rotation = rotationVector
////        }
//    }









