//
//  AutoHeightCollectionView.swift
//  common
//
//  Created by Remote User on 12/19/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit


public class AutoHeightCollectionView: UICollectionView {
    
    private var minHeight:CGFloat=0
    private weak var heightConstraint:NSLayoutConstraint?
     @IBInspectable public var maxHeight:CGFloat = -1
    @IBInspectable public var layoutChangeAnimation:Bool = true
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
          addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil)
        associateConstraints()
    }
    
    fileprivate func associateConstraints() {
        for constraint in self.constraints {
            if (constraint.firstAttribute == .height) {
                if (constraint.relation == .equal) {
                    self.heightConstraint = constraint
                    minHeight=constraint.constant
                }
            }
        }
    }

    deinit {
        removeObserver(self, forKeyPath: "contentSize")
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath=="contentSize"{
            var newHeight = collectionViewLayout.collectionViewContentSize.height
          
            if maxHeight > -1{
                newHeight = newHeight>maxHeight ? maxHeight : newHeight
            }

            
            heightConstraint?.constant = newHeight > minHeight ? newHeight : minHeight
            if layoutChangeAnimation{
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.superview?.layoutIfNeeded()
            })
            }
            else{
                superview?.layoutIfNeeded()
            }
        }
    }
}
