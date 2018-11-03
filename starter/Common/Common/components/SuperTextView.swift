//
//  SuperTextView.swift
//  common
//
//  Created by Remote User on 10/31/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit

//
//  GrowingTextView.swift
//  Footkal
//
//  Created by Remote User on 6/7/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SuperTextViewDelegate: UITextViewDelegate {
    @objc optional func textViewDidChangeHeight(_ textView: SuperTextView, height: CGFloat)
}

@IBDesignable @objc
open class SuperTextView: UITextView {
    
    
    // Maximum length of text. 0 means no limit.
    @IBInspectable open var maxLength: Int = 0
    
    // Trim white space and newline characters when end editing. Default is true
    @IBInspectable open var trimWhiteSpaceWhenEndEditing: Bool = false
    
    // Maximm height of the textview
    @IBInspectable open var maxHeight: CGFloat = CGFloat(0)
    
    // growing textviewbox
    @IBInspectable open var growing: Bool = false
    
    
    
    
    @IBInspectable public var background: UIColor = .clear {
        didSet{
            layoutSubviews()
        }
    }
    
    
    
    // Placeholder properties
    private var _placeholderLabel:UILabel?
    @IBInspectable public var placeholder: String? {
        get {
            return _placeholderLabel?.text
        }
        set {
            if let placeholderLabel = _placeholderLabel {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    // Placeholder color properties
    @IBInspectable public var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            if let placeholderLabel = _placeholderLabel {
                placeholderLabel.textColor=placeholderColor
            }
        }
    }
    
    
    override open var font: UIFont?{
        didSet{
            if let placeholderLabel = _placeholderLabel {
                placeholderLabel.font=font
            }
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    override open var textContainerInset:  UIEdgeInsets{
        didSet{
            self.resizePlaceholder()
        }
    }
    
    
    
    override open var text: String! {
        didSet {
            self.textDidChanged(textView: self)
            setNeedsDisplay()
        }
    }
    
    fileprivate  var heightConstraint: NSLayoutConstraint?
    
    // Initialize
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 38)
    }
    
    func associateConstraints() {
        // iterate through all text view's constraints and identify
        // height,from: https://github.com/legranddamien/MBAutoGrowingTextView
        for constraint in self.constraints {
            if (constraint.firstAttribute == .height) {
                if (constraint.relation == .equal) {
                    self.heightConstraint = constraint;
                }
            }
        }
    }
    
    // Listen to UITextView notification to handle trimming, placeholder and maximum length
    fileprivate func commonInit() {
        self.contentMode = .redraw
        associateConstraints()
        NotificationCenter.default.setObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
        NotificationCenter.default.setObserver(self, selector: #selector(textDidEndEditing), name: UITextView.textDidEndEditingNotification, object: self)
    }
    
    // Remove notification observer when deinit
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: self)
    }
    
    // Calculate height of textview
    private var oldText = ""
    private var oldWidth = CGFloat(0)
    private func handleHeight(){
        guard growing else {
            return
        }
        
        if text == oldText && oldWidth == bounds.width { return }
        oldText = text
        oldWidth = bounds.width
        
        let size = sizeThatFits(CGSize(width:bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
        let height = maxHeight > 0 ? min(size.height, maxHeight) : size.height
        
        if (heightConstraint == nil) {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
            addConstraint(heightConstraint!)
        }
        
        if height != heightConstraint?.constant {
            self.heightConstraint!.constant = height;
            scrollRangeToVisible(NSMakeRange(0, 0))
            if let delegate = delegate as? SuperTextViewDelegate {
                delegate.textViewDidChangeHeight?(self, height: height)
            }
        }
    }
    
    
    
    // Trim white space and new line characters when end editing.
    @objc  func textDidEndEditing(notification: Notification) {
        if let notificationObject = notification.object as? SuperTextView {
            if notificationObject === self {
                if trimWhiteSpaceWhenEndEditing {
                    text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    setNeedsDisplay()
                }
            }
        }
    }
    
    // Limit the length of text
    @objc open func textDidChange(notification: Notification) {
        if let notificationObject = notification.object as? SuperTextView {
            if notificationObject === self {
                if maxLength > 0 && text.count > maxLength {
                    
                    let endIndex = text.index(text.startIndex, offsetBy: maxLength)
                    text =  String(text[..<endIndex])
                    undoManager?.removeAllActions()
                }
                setNeedsDisplay()
                
                
                if let placeholderLabel = _placeholderLabel {
                    placeholderLabel.isHidden = self.text.count > 0
                }
            }
        }
    }
    
    //placeHolder visibility
    open func textDidChanged(textView: UITextView) {
        
        if let placeholderLabel = _placeholderLabel {
            placeholderLabel.isHidden = textView.text.count > 0
        }
    }
    
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = _placeholderLabel {
            let labelX = self.textContainer.lineFragmentPadding + textContainerInset.left
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String)
    {
        
        _placeholderLabel = UILabel()
        
        _placeholderLabel!.text = placeholderText
        _placeholderLabel!.sizeToFit()
        
        _placeholderLabel!.font = self.font
        _placeholderLabel!.textColor = placeholderColor
        
        _placeholderLabel!.isHidden = self.text.count > 0
        
        self.addSubview(_placeholderLabel!)
        self.resizePlaceholder()
    }
    
    
    
    
    
    // handle view layer
    private func handleLayer() {
        
        //        layer.borderWidth = borderWidth
        //        layer.borderColor = borderColor?.cgColor
        layer.backgroundColor = background.cgColor
        clipsToBounds = true
        
        if growing{
            let path = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.5, dy: 0.5), cornerRadius: cornerRadius)
            let mask = CAShapeLayer()
            
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        handleLayer()
        handleHeight()
    }
}










