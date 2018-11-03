//
//  PreferencesExplorer.swift
//  common
//
//  Created by Remote User on 3/14/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation
import UIKit

public enum PreferenceType: String {
    
    case about = "General&path=About"
    case accessibility = "General&path=ACCESSIBILITY"
    case airplaneMode = "AIRPLANE_MODE"
    case autolock = "General&path=AUTOLOCK"
    case cellularUsage = "General&path=USAGE/CELLULAR_USAGE"
    case brightness = "Brightness"
    case bluetooth = "Bluetooth"
    case dateAndTime = "General&path=DATE_AND_TIME"
    case facetime = "FACETIME"
    case general = "General"
    case keyboard = "General&path=Keyboard"
    case castle = "CASTLE"
    case storageAndBackup = "CASTLE&path=STORAGE_AND_BACKUP"
    case international = "General&path=INTERNATIONAL"
    case locationServices = "LOCATION_SERVICES"
    case accountSettings = "ACCOUNT_SETTINGS"
    case music = "MUSIC"
    case equalizer = "MUSIC&path=EQ"
    case volumeLimit = "MUSIC&path=VolumeLimit"
    case network = "General&path=Network"
    case nikePlusIPod = "NIKE_PLUS_IPOD"
    case notes = "NOTES"
    case notificationsId = "NOTIFICATIONS_ID"
    case phone = "Phone"
    case photos = "Photos"
    case managedConfigurationList = "General&path=ManagedConfigurationList"
    case reset = "General&path=Reset"
    case ringtone = "Sounds&path=Ringtone"
    case safari = "Safari"
    case assistant = "General&path=Assistant"
    case sounds = "Sounds"
    case softwareUpdateLink = "General&path=SOFTWARE_UPDATE_LINK"
    case store = "STORE"
    case twitter = "TWITTER"
    case facebook = "FACEBOOK"
    case usage = "General&path=USAGE"
    case video = "VIDEO"
    case vpn = "General&path=Network/VPN"
    case wallpaper = "Wallpaper"
    case wifi = "WIFI"
    case tethering = "INTERNET_TETHERING"
    case blocked = "Phone&path=Blocked"
    case doNotDisturb = "DO_NOT_DISTURB"
    case privacy = "Privacy"
    
}

public enum PreferenceExplorerError: Error {
    case notFound(String)
}

public class PreferencesExplorer {
    
    // MARK: - Class properties -
    
    static private let preferencePath = "App-Prefs:root"
    
    // MARK: - Class methods -
    
  public  static func open(_ preferenceType: PreferenceType) throws {
        var preferencePath: String
        if #available(iOS 11.0, *), preferenceType == .video || preferenceType == .locationServices || preferenceType == .photos {
            preferencePath = UIApplication.openSettingsURLString
        } else {
            preferencePath = "\(PreferencesExplorer.preferencePath)=\(preferenceType.rawValue)"
        }
        
        if let url = URL(string: preferencePath) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            throw PreferenceExplorerError.notFound(preferencePath)
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
