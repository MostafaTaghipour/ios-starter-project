//
//  BuildConfig.swift
//  project
//
//  Created by Remote User on 10/14/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation

public class BuildConfig {
    public static var isDebugMode:Bool
    {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    public static var type:ConfigType{
        #if ENV_DEV
        return .development
        #elseif ENV_STG
        return .staging
        #elseif ENV_PRD
        return .production
        #endif
    }
}

public enum ConfigType {
    case development
    case staging
    case production
}

