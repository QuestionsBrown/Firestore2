//
//  TabarController.swift
//  FireStore2
//
//  Created by Concetta Turner on 6/1/19.
//  Copyright © 2019 Concetta Turner. All rights reserved.
//

import Foundation
import UIKit

class TabarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.white
        setupTabr()
        delegate = self
        
    }


    func setupTabr() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeVC = HomeScreenVC()
        let navC = UINavigationController(rootViewController: homeVC)
        
        navC.title = "Home"
        
        //        navC.tabBarItem.image = UIImage.init(named: "hommme")
        viewControllers = [navC]
        
        
        if let arVC = storyboard.instantiateViewController(withIdentifier: "ARVC") as? ARVC {
            let navC2 = UINavigationController(rootViewController: arVC)
            navC2.title = "3D Shop"
            //            navC2.tabBarItem.image = UIImage.init(named: "hommme")
            
            
            if let moreVC = storyboard.instantiateViewController(withIdentifier: "SearchTableVC") as? SearchTableVC {
                let navC3 = UINavigationController(rootViewController: moreVC)
                navC2.title = "More"
                //                navC2.tabBarItem.image = UIImage.init(named: "hommme")
                
                var array = self.viewControllers
                array?.append(navC2)
                array?.append(navC3)
                self.viewControllers = array
                
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
