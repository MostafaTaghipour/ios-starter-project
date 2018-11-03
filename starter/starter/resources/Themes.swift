//
//  Themes.swift
//  project
//
//  Created by Remote User on 11/30/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit
import mtpThemeManager

protocol AppTheme:DayNightTheme {
    var secondaryTextColor: UIColor {get}
}

class RedTheme:AppTheme {
    required  init() {}
    var id: Int=1
    var displayName: String="Red"
    var tintColor: UIColor = R.color.tintColor()
    var backgroundColor: UIColor = R.color.backgroundColor()
    var textColor : UIColor = R.color.textColor()
    var secondaryTextColor: UIColor = R.color.text87Color()
}


var currentTheme : AppTheme {
    return ThemeManager.shared.currentTheme as! AppTheme
}

