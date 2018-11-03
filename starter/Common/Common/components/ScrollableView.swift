//
//  ScrollableView.swift
//  common
//
//  Created by Remote User on 12/5/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit

public class ScrollableView: UIScrollView {
    
    private var containerHeightConstraint:NSLayoutConstraint?
    private var containerWidthConstraint:NSLayoutConstraint?
    
    
    @IBInspectable public var containerHeightConstraintConstant:CGFloat = 0 {
        didSet{
            containerHeightConstraint?.constant=containerHeightConstraintConstant
        }
    }
    
    @IBInspectable public var containerWidthConstraintConstant:CGFloat = 0 {
        didSet{
            containerWidthConstraint?.constant=containerWidthConstraintConstant
        }
    }
    
   public lazy var containerView = { [unowned self] () -> UIView in
        
        let view=UIView()
        self.addSubview(view)
        
        view.backgroundColor = .clear
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        if let superView = self.superview{
            
            
            if #available(iOS 11, *) , superView.superview==nil{
                let guide = superView.safeAreaLayoutGuide
                self.containerWidthConstraint = view.widthAnchor.constraint(equalTo: guide.widthAnchor)
                self.containerHeightConstraint = view.heightAnchor.constraint(equalTo: guide.heightAnchor)
            }
            else{
                self.containerWidthConstraint = view.widthAnchor.constraint(equalTo: superView.widthAnchor)
                self.containerHeightConstraint = view.heightAnchor.constraint(equalTo: superView.heightAnchor)
            }
            
            self.containerWidthConstraint?.isActive=true
            self.containerWidthConstraint?.constant=self.containerWidthConstraintConstant
            self.containerHeightConstraint?.priority = .defaultLow
            self.containerHeightConstraint?.constant=self.containerHeightConstraintConstant
            self.containerHeightConstraint?.isActive=true
        }
        
        return view
        }()
    
    
    
    init() {
        super.init(frame: CGRect.zero)
        setContent(contentView: subviews.first)
    }
    
    init(contentView:UIView) {
        super.init(frame: CGRect.zero)
        setContent(contentView: contentView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContent(contentView: subviews.first)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setContent(contentView: subviews.first)
    }
    
    public  override func awakeFromNib() {
        super.awakeFromNib()
        setContent(contentView: subviews.first)
    }
    
    
    
    
    public func setContent(contentView:UIView?){
        
        guard superview != nil , let contentView = contentView else{
            return
        }
        
        
        contentView.removeFromSuperview()
        containerView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor).isActive = true
    }
    
}
