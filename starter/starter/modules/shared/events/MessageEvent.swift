//
//  MessageEvent.swift
//  project
//
//  Created by Remote User on 12/30/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
class MessageEvent:BusEvent {
    var title:String?=nil
    var body:String
    var style:MessegeStyle = .regular
    var onTop:Bool = false
 
    init(  title:String?=nil,
           body:String,
           style:MessegeStyle = .regular,
           onTop:Bool = false) {
        
        self.title=title
        self.body=body
        self.style=style
        self.onTop = onTop
    }
    
    func show()  {
        styledMessage(title, body: body, style: style,topAll: onTop)
    }
}


