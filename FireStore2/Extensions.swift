//
//  Extensions.swift
//  FireStore2
//
//  Created by Concetta Turner on 11/5/18.
//  Copyright © 2018 Concetta Turner. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
import ARKit
import SceneKit

//extension HomeScreenVC {
//    func topMostViewController() -> UIViewController {
//        if self.presentedViewController == nil {
//            return self
//        }
//        if let navigation = self.presentedViewController as? UINavigationController {
//            return navigation.visibleViewController.topMostViewController()
//        }
//        if let tab = self.presentedViewController as? UITabBarController {
//            if let selectedTab = tab.selectedViewController {
//                return selectedTab.topMostViewController()
//            }
//            return tab.topMostViewController()
//        }
//        return self.presentedViewController!.topMostViewController()
//    }
//}
//
//extension UIApplication {
//    func topMostViewController() -> UIViewController? {
//        return self.keyWindow?.rootViewController?.topMostViewController()
//    }
//}

extension UIStoryboardSegue {
    /**
     Call this function to start a double dispatch between the destination and source of this segue.
     - Precondition: The segue.destination UIViewController must implement prepareAsDestination( segue: UIStoryboardSegue, sender: Any?)
     - Parameter sender : the UIControl that triggers the segue
     
     **Example**
     ```
     //The SourceVC
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
     {
     segue.prepare(sender: sender)
     }
     
     //Prepare segue to DestinationVC
     func prepare( segue: UIStoryboardSegue, to destination: DestinationVC, from sender: Any?) {
     ...
     }
     
     ```
     ```
     //The DestinationVC
     
     override func prepareAsDestination(segue: UIStoryboardSegue, sender: Any?) {
     
     let sourceVC = segue.source as! SourceVC
     source.prepare(segue: segue, to: self, from: sender)
     }
     
     
     ```
     */
    
    func prepare(sender : Any?) {
        guard let destination = self.destination as? SegueDestination else{ fatalError("Destination \(self.destination) does not conform to SegueDestination protocol")}
        destination.prepareAsDestination(segue: self, sender: sender)
    }
}

extension UINavigationController : SegueDestination
{
    func prepareAsDestination( segue: UIStoryboardSegue, sender: Any?){
        guard let destination = self.topViewController as? SegueDestination
            else{ fatalError("Top view contoroller must conform to protocol SegueDestination")}
        
        destination.prepareAsDestination(segue: segue, sender: sender)
    }
}


import UIKit
import ImageIO

extension UIImageView {
    
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}

extension UIView {
    
    
    //    FIND AND RETURN CURRENT COLLECTIONVIEW ON UIVIEW^
    func findCollectionView() -> UICollectionView? {
        if let collectionView = self as? UICollectionView {
            return collectionView
        } else {
            return superview?.findCollectionView()
        }
    }
    
    //    FIND THE CURRENT COLLECTION VIEW CELL
    func findCollectionViewCell() -> UICollectionViewCell? {
        if let cell = self as? UICollectionViewCell {
            return cell
        } else {
            return superview?.findCollectionViewCell()
        }
    }
    
    //    FIND INDEX PATH TO BE USED IN COLLECTIONVIEW DELEGATE FUNCS
    func findCollectionViewIndexPath() -> IndexPath? {
        guard let cell = findCollectionViewCell(), let collectionView = cell.findCollectionView() else { return nil }
        
        //FIND INDEX PATH OF CERTAIN CELL IN DETERMINED COLLECTIONVIEW
        return collectionView.indexPath(for: cell)
    }
    
}

extension UIImage {
    
    //MARK GIF
    
    //    FROM DATA VERSION
    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    //    IN URL VERSION
    
    public class func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    //IN BUNDLE VERSION
    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
            return delay
        }
        
        let gifProperties:CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        
        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as? Double ?? 0
        
        if delay < 0.1 {
            delay = 0.1 // Make sure they're not too fast
        }
        
        return delay
    }
    
    internal class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        // Check if one of them is nil
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        // Swap for modulo
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        
        // Get greatest common divisor
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b! // Found it
            } else {
                a = b
                b = rest
            }
        }
    }
    
    internal class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        // Fill arrays
        for i in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        // Calculate full duration
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
    
}


//find out how man nib files you need for all catagories 40 = 50 Nib Files



extension QueryDocumentSnapshot {
    //Generic Function Which Trys to return Generic Type T (Dictionary,String,Array,Int Whatever Type from firebase
    func decoded<T: Decodable>() throws -> T { 
        //create variable that tries to use ios Native JSonSerilization Function to decode data from firebase
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        // create variable object to be decoded into generic type T then returned
        let object = try JSONDecoder().decode(T.self, from: jsonData)
        return object
    }
}

extension QuerySnapshot {
    //generic function of type decodable trying to return an array of Type Decodable
    func decoded<Type: Decodable>() throws -> [Type] {
        //Variable to Return As [Type] which is equal to all documents inside the snapshot trying to run the decoded method above which
        let objects: [Type] = try documents.map({ try $0.decoded() })
        //return the above let becasue it is now the correct type of an array of Type [Type] through firebase
        return objects
    }
}

extension Collection {
    
    subscript(optional i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }
    
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}


struct ColorsStuct {
    
    static  let logoColor = UIColor(red: 0.949, green: 0.365, blue: 0.137, alpha: 1.00)
    static  let cellContentBackroundColor = UIColor(red: 0.969, green: 0.953, blue: 0.137, alpha: 1.00)
    static  let cellContentBackroundColor2 = UIColor(red: 0.969, green: 0.953, blue: 0.910, alpha: 1.00)
    
    //vs
    
    let logoColor = UIColor(red: 0.949, green: 0.365, blue: 0.137, alpha: 1.00)
    let cellContentBackroundColor = UIColor(red: 0.969, green: 0.953, blue: 0.137, alpha: 1.00)
    let cellContentBackroundColor2 = UIColor(red: 0.969, green: 0.953, blue: 0.910, alpha: 1.00)
    
}


struct ColorsStruct2 {

    let logoColor: UIColor
    let cellContentBackroundColor: UIColor
    let cellContentBackroundColor2: UIColor

    
    init(logoColor: UIColor, cellContentBackroundColor: UIColor, cellContentBackroundColor2: UIColor ) {
        self.logoColor = logoColor
        self.cellContentBackroundColor = cellContentBackroundColor
        self.cellContentBackroundColor2 = cellContentBackroundColor2
    }
}


struct ColorsStruct3 {
    
    let logoColor: UIColor?
    let cellContentBackroundColor: UIColor?
    let cellContentBackroundColor2: UIColor?
    
    
    init(logoColor: UIColor?, cellContentBackroundColor: UIColor?, cellContentBackroundColor2: UIColor?) {
        self.logoColor = logoColor
        self.cellContentBackroundColor = cellContentBackroundColor
        self.cellContentBackroundColor2 = cellContentBackroundColor2
    }
}


class colorClass {

    let logoColor = UIColor(red: 0.949, green: 0.365, blue: 0.137, alpha: 1.00)
    let cellContentBackroundColor = UIColor(red: 0.969, green: 0.953, blue: 0.137, alpha: 1.00)
    let cellContentBackroundColor2 = UIColor(red: 0.969, green: 0.953, blue: 0.910, alpha: 1.00)
    
//    vs
    
    static let logoColor = UIColor(red: 0.949, green: 0.365, blue: 0.137, alpha: 1.00)
    static let cellContentBackroundColor = UIColor(red: 0.969, green: 0.953, blue: 0.137, alpha: 1.00)
    static let cellContentBackroundColor2 = UIColor(red: 0.969, green: 0.953, blue: 0.910, alpha: 1.00)
    
    
}

class colorClass2 {
    
    
    let logoColor: UIColor
    let cellContentBackroundColor: UIColor
    let cellContentBackroundColor2: UIColor
    
    
    init(logoColor: UIColor, cellContentBackroundColor: UIColor, cellContentBackroundColor2: UIColor ) {
        self.logoColor = logoColor
        self.cellContentBackroundColor = cellContentBackroundColor
        self.cellContentBackroundColor2 = cellContentBackroundColor2
    }
    
}


extension MDLMaterial {
    func setTextureProperties(_ textures: [MDLMaterialSemantic:String], folderName: String) -> Void {
        for (key,value) in textures {
            
            //            guard let url = Bundle.main.url(forResource: value, withExtension: "") else {
            //                fatalError("Failed to find URL for resource \(value).")
            //            }
            
            let tempfolder = getDirectoryPath().appendingPathComponent(folderName)
            
            let property = MDLMaterialProperty(name:value, semantic: key, url: tempfolder)
            self.setProperty(property)
        }
    }
    //Refactor Into Protocol Delegates
    func getDirectoryPath() -> URL {
        //        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Q'sDirectory")
        let path2 = NSTemporaryDirectory() as String
        //        let url = NSURL(string: path)
        let url2 = NSURL(string: path2)
        return url2! as URL
    }
    
}



//extension ViewController: ARSessionObserver {
//
//    func sessionWasInterrupted(_ session: ARSession) {
//        showARGuidePrompt("Session was interrupted")
//    }
//
//    func sessionInterruptionEnded(_ session: ARSession) {
//        startNewSession()
//    }
//
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        showARGuidePrompt("Session failed: \(error.localizedDescription)")
//        startNewSession()
//    }
//
//    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
//        var message: String? = nil
//
//        switch camera.trackingState {
//
//        case .notAvailable:
//            message = "AR available"
//
//        case .limited(.initializing):
//            message = "Initializing AR session"
//
//        case .limited(.excessiveMotion):
//            message = "Too much motion"
//
//        case .limited(.insufficientFeatures):
//            message = "Move Camera Slowly"
//
//        case .normal:
//            print("Find Horizontal Plane First")
//            //            if !world.isVisible() {
//            //                message = "Move to find a horizontal surface"
//        //            }
//        default:
//            // We are only concerned with the tracking states above.
//            message = "Camera changed tracking state"
//        }
//        message != nil ? showARGuidePrompt(message!) : hideToast()
//    }
//}


extension SCNNode {
    
    func changeAltitude(value: Float) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1
        //        helicopterNode.position = SCNVector3(helicopterNode.position.x, value, helicopterNode.position.z)
        self.eulerAngles = SCNVector3Make(value, self.position.x, self.position.y)
        //        helicopterNode.runAction(SCNAction.rotate(by: 0.1, around: SCNVector3Make(0, 1, 0), duration: 1))
        SCNTransaction.commit()
    }
    
    func cleanupMeshes() {
        for child in childNodes {
            child.cleanupMeshes()
        }
        
        //Firebase Database Set Geometry & Texture NEEDED
        geometry = nil
        geometry?.materials.removeAll()
        self.isHidden = true
        removeFromParentNode()
        print("MeshesCleaned")
    }
    
    func fadeItem() {
        let fadeIn = SCNAction.fadeIn(duration: 0)
        self.runAction(fadeIn)
    }
    
    func stopSpinActions() {
        
        self.removeAllActions()
        let deadlineTime = DispatchTime.now() + .seconds(0)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.runAction(SCNAction.repeat(.rotateBy(x: 0, y: 0, z: 0, duration: 1), count: 1))
        }
        self.removeAllActions()
    }
    
    func moveTo(viewSpotPos : SCNVector3) {
        let moveTo = SCNAction.move(to: viewSpotPos, duration: 1)
        //        let scaleBy = SCNAction.scale(by: 1, duration: 1)
        self.runAction(moveTo)
        //        self.runAction(scaleBy)
    }
    
    func snapBack(viewSpotPos : SCNVector3) {
        let moveTo = SCNAction.move(to: viewSpotPos, duration: 0)
        //        let scaleBy = SCNAction.scale(by: 1, duration: 1)
        self.runAction(moveTo)
        //        self.runAction(scaleBy)
    }
    
    func returnItemToOriginalShelfSpot(itemOrigin : SCNVector3) {
        let moveTo = SCNAction.move(to: itemOrigin, duration: 1)
        self.runAction(moveTo)
    }
    
    func rotate(by worldRotation: SCNQuaternion, worldTarget: SCNVector3) {
        let moveTo = SCNAction.rotate(by: 2, around: worldTarget, duration: 30)
        self.runAction(moveTo)
    }
    
    
    func spinY() {
        let deadlineTime = DispatchTime.now() + .seconds(0)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.runAction(SCNAction.repeat(.rotateBy(x: 0, y: 6.4, z: 0, duration: 5), count: 20))
        }
    }
    
    func spinZ() {
        let deadlineTime = DispatchTime.now() + .seconds(0)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.runAction(SCNAction.repeat(.rotateBy(x: 0, y: 0, z: 6.4, duration: 5), count: 20))
        }
    }
    
    func spinX() {
        let deadlineTime = DispatchTime.now() + .seconds(0)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.runAction(SCNAction.repeat(.rotateBy(x: 6.4, y: 0, z: 0, duration: 10), count: 20))
        }
    }
    
    func rotate3(floatn: CGFloat, floatn2: CGFloat, Floatin3: CGFloat, durationn: TimeInterval) {
        
        let moveAround = SCNAction.rotateTo(x: floatn, y: floatn2, z: Floatin3, duration: durationn)
        
        self.runAction(moveAround)
    }
    
    func directionsFadeOut() {
        let fadeOut = SCNAction.fadeOpacity(by: -0.50, duration: 0.50)
        self.runAction(fadeOut)
    }
    
    func directionsFadeIn() {
        let fadeIn = SCNAction.fadeOpacity(by: 0.50, duration: 0.50)
        self.runAction(fadeIn)
    }
    
    
    
    
    private static let highlightAnimationKey = "highlightAnimationKey"
    private static let dehighlightAnimationKey = "dehighlightAnimationKey"
    private static let highlightAnimationDuration = 0.15
    
    /**
     Add a new highlight fitler if no one already exists
     */
    private func addHighlightFilter(glowIntensity: Double, glowRadius: Double) {
        if highlightFilterExist() { return }
        
        let newHighlightFilter = HighlightFilter()
        newHighlightFilter.name = HighlightFilter.filterName
        newHighlightFilter.setValue(NSNumber(floatLiteral: glowRadius), forKey: "inputRadius")
        newHighlightFilter.setValue(NSNumber(floatLiteral: glowIntensity), forKey: "inputIntensity")
        
        if self.filters != nil {
            self.filters?.append(newHighlightFilter)
        }
        else {
            self.filters = [newHighlightFilter]
        }
    }
    
    func highlight(glowIntensity: Double = 6.0, glowRadius: Double = 30.0) {
        addHighlightFilter(glowIntensity: glowIntensity, glowRadius: glowRadius)
        
        SCNTransaction.begin()
        let animation = CABasicAnimation(keyPath: "filters.highlightFilter.inputIntensity")
        animation.fromValue = 0.0
        animation.duration = SCNNode.highlightAnimationDuration
        SCNTransaction.completionBlock = {
            // We add the filter again in case it was removed by dehighlight at the same time
            self.addHighlightFilter(glowIntensity: glowIntensity, glowRadius: glowRadius)
        }
        self.addAnimation(animation, forKey: SCNNode.highlightAnimationKey)
        SCNTransaction.commit()
    }
    
    func dehighlight() {
        if let highlightFilter = highlightFilter() {
            let currentIntensity = highlightFilter.inputIntensity!
            highlightFilter.setValue(NSNumber(floatLiteral: 0.0), forKey: "inputIntensity")
            SCNTransaction.begin()
            let animation = CABasicAnimation(keyPath: "filters.highlightFilter.inputIntensity")
            animation.fromValue = currentIntensity
            animation.duration = SCNNode.highlightAnimationDuration
            SCNTransaction.completionBlock = {
                self.removeHighlightFilter()
            }
            self.addAnimation(animation, forKey: SCNNode.dehighlightAnimationKey)
            SCNTransaction.commit()
        }
    }
    
    
    private func removeHighlightFilter() {
        if let highlightFilterIndex = self.highlightFilterIndex() {
            self.filters?.remove(at: highlightFilterIndex)
        }
    }
    
    private func highlightFilter() -> HighlightFilter? {
        guard let highlightFilterIndex = highlightFilterIndex() else {
            return nil
        }
        return filters?[highlightFilterIndex] as? HighlightFilter
    }
    
    private func highlightFilterIndex() -> Int? {
        return filters?.map{$0.name}.index(of: HighlightFilter.filterName) ?? nil
    }
    
    
    
    private func highlightFilterExist() -> Bool {
        return filters?.map{$0.name}.contains(HighlightFilter.filterName) ?? false
    }
    
}



class HighlightFilter: CIFilter {
    
    static let filterName = "highlightFilter"
    
    @objc dynamic var inputImage: CIImage?
    @objc dynamic var inputIntensity: NSNumber?
    @objc dynamic var inputRadius: NSNumber?
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        let bloomFilter = CIFilter(name:"CIBloom")!
        bloomFilter.setValue(inputImage, forKey: kCIInputImageKey)
        bloomFilter.setValue(inputIntensity, forKey: "inputIntensity")
        bloomFilter.setValue(inputRadius, forKey: "inputRadius")
        
        let sourceOverCompositing = CIFilter(name:"CISourceOverCompositing")!
        sourceOverCompositing.setValue(inputImage, forKey: "inputImage")
        sourceOverCompositing.setValue(bloomFilter.outputImage, forKey: "inputBackgroundImage")
        
        return sourceOverCompositing.outputImage
    }
    
}


extension ARVC {
    
    func loadGestures () {
        
        let selectItem = UITapGestureRecognizer(target: self, action: #selector(tapSelect(restap: )))
        selectItem.numberOfTapsRequired = 1
        
        let panObj = UIPanGestureRecognizer(target: self, action: #selector(rotateObject(rec:)))
        
        let scaleItemsPinch = UIPinchGestureRecognizer(target: self, action: #selector(scaleItems(rec:)))
        
        let holdTapToSeeTV = UILongPressGestureRecognizer(target: self, action: #selector(holdTapVideo(resholdtap:)))
        
        //                let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(rec: )))
        //                swipeLeft.direction = .left
        
        sceneView?.addGestureRecognizer(selectItem)
        sceneView?.addGestureRecognizer(panObj)
        sceneView?.addGestureRecognizer(scaleItemsPinch)
        sceneView?.addGestureRecognizer(holdTapToSeeTV)
        //                sceneView.addGestureRecognizer(swipeLeft)
    }
    
    func startNewSession2() {
        // hide toast
//        self.arLabelBackround.alpha = 0
//        self.arLabelBackround.frame = self.arLabelBackround.frame.insetBy(dx: 5, dy: 5)
        
        //        hideItemDetails()
        //        disableTaps3()
        
        // Create a session configuration with horizontal plane detection
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        //        if #available(iOS 11.3, *) {
        //                        configuration.isAutoFocusEnabled = true
        //                    } else {
        // Run the view's session
        sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
        //                    }
    }

    
//    func playSongs() {
//        let url = URL(string: "https://k003.kiwi6.com/hotlink/r16tj49ild/Diego_Money_and_Famous_Dex_-_Goyard4k_Prod._UglyFriend_.mp3")
//        self.readyPlayer(url: url!)
//    }
    
//    func readyPlayer(url: URL) {
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//            player = AVPlayer(url: url)
//            player?.play()
//        } catch {
//            print(error)
//        }
//    }
    
    
    
    
    
}

//extension UIView {
//    func toImage() -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
//        
//        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
//        
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
//    }
//    
//    func flashh() {
//        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.duration = 0.7
//        flash.fromValue = 1
//        flash.toValue = 0
//        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        flash.autoreverses = true
//        flash.repeatCount = 3
//        layer.add(flash, forKey: nil)
//    }
//    
//    func fla() {
//        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.duration = 0.7
//        flash.fromValue = 1
//        flash.toValue = 0
//        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        flash.autoreverses = true
//        layer.add(flash, forKey: nil)
//    }
//    
//}
//
//extension UIButton {
//    
//    func fadeIn() {
//        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.duration = 0.9
//        flash.fromValue = 1
//        flash.toValue = 0
//        
//        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        layer.add(flash, forKey: nil)
//    }
//    
//    func flashHelp() {
//        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.duration = 0.7
//        flash.fromValue = 1
//        flash.toValue = 0
//        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        flash.autoreverses = true
//        flash.repeatCount = 3
//        layer.add(flash, forKey: nil)
//    }
//    
//}
//
//extension UILabel {
//    
//    func fadeIn() {
//        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.duration = 5
//        flash.fromValue = 1
//        flash.toValue = 0
//        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        flash.autoreverses = true
//        flash.repeatCount = 0
//        layer.add(flash, forKey: nil)
//    }
//    
//    func flashHelp() {
//        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.duration = 0.7
//        flash.fromValue = 1
//        flash.toValue = 0
//        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        flash.autoreverses = true
//        flash.repeatCount = 20
//        layer.add(flash, forKey: nil)
//        
//    }
//}
//
//extension UIImageView {
//    
//    func flashHelp() {
//        let flash = CABasicAnimation(keyPath: "opacity")
//        flash.duration = 0.7
//        flash.fromValue = 1
//        flash.toValue = 0
//        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        flash.autoreverses = true
//        flash.repeatCount = 20
//        layer.add(flash, forKey: nil)
//    }
//}
//




//            detailViewController.selectedImageName = cellImages[indexPath.row]
//            detailViewController.selectedLabel = cellLabels[indexPath.row]
//ALL NODE NAMES JSON
//        let imagesArray = donuts[indexPath3.row].imageRef
//        let storageBih = Storage.storage().reference().child("images").child(imagesArray)
//
//        detailViewController.imageBih?.sd_setImage(with: sugarShackLogo)

//        guard let indexPath3 = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
//
//
//        guard let detailViewController = segue.destination as? DetailViewController else { return }

//        let detailVC = DetailViewController()

//ALL NODE NAMES JSON


//        let detailVC = DetailViewController()


//         detailVC.lbl?.text = donuts[indexPath.row].name

//        let imagesArray = donuts[indexPath.row].imageRef
//        let storageBih = Storage.storage().reference().child("images").child(imagesArray)
//        detailVC.imageBih?.sd_setImage(with: storageBih)
//
//        detailVC.name = donuts[indexPath.row].description


//        detailVC.lbl?.text = detailVC.name


////
//        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController")as? DetailViewController
//                vc?.name = donuts[indexPath.row].name
//        self.navigationController?.pushViewController(vc!, animated: true)
//


//        let imagesArray = donuts[indexPath.row].imageRef
//        //SET
//        let storageBih = Storage.storage().reference().child("images").child(imagesArray)
//
//
//        let mainStory: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let indexPath = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
//        let desVC = mainStory.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//
////        desVC.img.image =
//
//        self.navigationController?.pushViewController(desVC, animated: true)
//                desVC.lbl!.text = donuts[indexPath.row].name
////
////
////
//        print(indexPath.row + 1)


//            detailViewController.selectedImageName = cellImages[indexPath.row]
//            detailViewController.selectedLabel = cellLabels[indexPath.row]''


//
//    var programmaticReturn: UILabel = {
//        let retrubLabel = UILabel()
//        retrubLabel.text = "fgdcfchfgh"
////        retrubLabel.font =
//        retrubLabel.textColor = UIColor.blue
//        retrubLabel.translatesAutoresizingMaskIntoConstraints = false
////        retrubLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
////        retrubLabel.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
//        return retrubLabel
//    }()

//extension Array {
//    func getElement(at index: Int) -> Element? {
//        let isValidIndex = index >= 0 && index < count
//        return isValidIndex ? self[index] : nil
//    }
//}
//
//extension Array {
//    subscript(safe index: Index) -> Element? {
//        let isValidIndex = index >= 0 && index < count
//        return isValidIndex ? self[index] : nil
//    }
//}
//
//extension Collection {
//    subscript(safe index: Index) -> Element? {
//        return indices.contains(index) ? self[index] : nil
//    }
//}
