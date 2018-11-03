//
//  AppAssembler.swift
//  project
//
//  Created by Remote User on 9/29/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration
import mtpFontManager
import mtpLocaleManager
import mtpThemeManager


class AppAssembler{
    
    private var assembler : Assembler!
    
    var r : Resolver{
        return assembler.resolver
    }
    
    
    init(container:Container) {
        assembler = Assembler(container: container)
        registerGlobalDependencies(container: container)
        applyAssemblies()
    }
    
    private func registerGlobalDependencies(container:Container){
        container.register(UIApplication.self){_ in UIApplication.shared}.inObjectScope(.container)
        container.register(AppDelegate.self){r in (r~>UIApplication.self).delegate as! AppDelegate}.inObjectScope(.container)
        container.register(UIWindow.self){r in (r~>AppDelegate.self).window!}.inObjectScope(.container)
        container.register(UserDefaults.self){_ in UserDefaults.standard}
        container.autoregister(CredentionalsRepo.self, initializer: SecureUserDefaultsRepo.init).inObjectScope(.container)
        container.register(AppFont.self){_ in AppFont.shared}.inObjectScope(.container)
        container.register(ThemeManager.self){_ in ThemeManager.shared}.inObjectScope(.container)
        container.register(LocaleManager.self){_ in LocaleManager.shared}.inObjectScope(.container)
        container.register(AppTheme.self){ r in (r~>ThemeManager.self).currentTheme as! AppTheme}
        container.register(Locale.self){r in (r~>LocaleManager.self).currentLocale}
    }
    
    private func applyAssemblies() {
        // todo: add assemblies to app assembler like below
        /* assembler.apply(assembly: SampleAssembly()) */
    }
}
