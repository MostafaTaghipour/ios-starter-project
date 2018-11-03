//
//  MainTBC.swift
//  project
//
//  Created by Remote User on 12/2/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit
import RxSwift


enum MainTabbarItem : Int , CaseIterable{
    case sample = 0
    
    func generateNavigationController() -> UIViewController{
        
        switch self{
        case .sample:
            // todo: define viewControllers  you want add to main tabbar like below
            /*
             let sampleVC=R.storyboard.sample.sampleViewController.create(withSwingectStoryboard: R.storyboard.sample)!
             sampleVC.tabBarItem=UITabBarItem(title: R.string.sampleStrings.title(), image: nil, tag: rawValue)
             return sampleVC
             */
            return UIViewController()
        }
        
    }
    
    static func generateNavigationControllerForAllItems(except:[MainTabbarItem]? = nil) -> [UIViewController] {
        var res = [UIViewController]()
        for item in self.allCases{
            if except == nil || !except!.contains(item){
                res.append(item.generateNavigationController())
            }
        }
        return res
    }
    
}

class MainTBC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = setupItems()
    }
    
    
    
    private func setupItems()->[UIViewController]{
        return MainTabbarItem.generateNavigationControllerForAllItems()
            .map{UINavigationController(rootViewController: $0)}
            .sorted(by: { (first, second) -> Bool in
                first.tabBarItem.tag < second.tabBarItem.tag
            })
    }
}


