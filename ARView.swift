//
//  ARView.swift
//  FireStore2
//
//  Created by Concetta Turner on 3/28/19.
//  Copyright © 2019 Concetta Turner. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import ModelIO
import SceneKit.ModelIO
import Speech





class ViewController: UIViewController  {
    
    

    @IBOutlet weak var sceneView: ARSCNView!
    var scnArray: [SCNScene]?
    
    @IBOutlet weak var viewHatsButton: UIButton!
    //Store Catagory World Variables TRANSFOM INTO STRUCT THEN ARRAY
    var foodWorld = World()


    override func viewDidLoad() {
        super.viewDidLoad()
        startNewSession()
        presetDessertsScene()
        foodWorld.viewCatagoryAllItems(relativeTransform: (sceneView.session.currentFrame?.camera.transform)!)
        
        //        startNewSession()
//        hideItemDetails()
//        loadGestures()
//        playSongs()
//        chooseCatagoryToStartPrompt()
//        configureAudioSession()
        
        //        worldsArray.init(sidesWorld: sidesWorld, brunchWorld: brunchWorld, lunchWorld: lunchWorld, dinnerWorld: dinnerWorld, dessertsWorld: dessertsWorld)
        
        //        slider.setThumbImage(UIImage(named:"homeButton"), for: .normal)
        //        slider.setThumbImage(UIImage(named:"homeButton"), for: .highlighted)
        //        presetStartScreen()
}


    func presetDessertsScene() {
//        hideItemDetails()
//        removeAllWorld()
        sceneView?.delegate = self
        sceneView?.antialiasingMode = .multisampling4X
        sceneView?.scene = foodWorld
        foodWorld.launchAllDonuts()
//        foodWorld.hideContentRootNode()
        sceneView?.automaticallyUpdatesLighting = false
        sceneView?.autoenablesDefaultLighting = false
        sceneView?.showsStatistics = false
//        showOnlyDessertsHiddenButton()

}
    
    

}
