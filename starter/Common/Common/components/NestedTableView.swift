//
//  NestedTableView.swift
//  Footkal
//
//  Created by Remote User on 5/16/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit

public class NestedTableView: UITableView {
    
    override public var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize{
        get{
            self.layoutIfNeeded()
           return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
        }
    }

}


