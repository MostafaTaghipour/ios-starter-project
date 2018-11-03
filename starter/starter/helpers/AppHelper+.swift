//
//  AppHelper+.swift
//  project
//
//  Created by Remote User on 12/2/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit
import SwinjectStoryboard
import Rswift

// MARK:- Swinject
public func inject<Service>() -> Service {
    return (UIApplication.shared.delegate as! AppDelegate).assembler.r.resolve(Service.self)!
}
public func injectOptional<Service>() -> Service? {
    return (UIApplication.shared.delegate as! AppDelegate).assembler.r.resolve(Service.self)!
}

// SwinjectStoryboard + R.Swift
extension StoryboardResourceType {
    
    var swinjectStoryboard : SwinjectStoryboard {
        return SwinjectStoryboard.create(name: name, bundle: bundle)
    }
    
    func create(_ storyboardResource: StoryboardResourceType) -> SwinjectStoryboard {
        
        let sb = SwinjectStoryboard.create(
            name: storyboardResource.name,
            bundle: storyboardResource.bundle)
        
        return sb
    }
}

extension StoryboardViewControllerResourceType {
    func create(withSwingectStoryboard storyboardResource: StoryboardResourceType) -> ViewControllerType? {
        return storyboardResource.swinjectStoryboard.instantiateViewController(withIdentifier: identifier) as? ViewControllerType
    }
}

