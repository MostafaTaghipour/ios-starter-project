    //
    //  UIHelper.swift
    //  common
    //
    //  Created by Remote User on 10/30/17.
    //  Copyright © 2017 hojan. All rights reserved.
    //
    
    import UIKit
    
    
    //MARK:- View
    //-----overlay
    public let overlayTag=19430
    extension UIView{
        
        public func removeOverlay(withAnimation:Bool=true,tag:Int=overlayTag){
            if let overlay=self.viewWithTag(tag){
                if withAnimation{
                    UIView.animate(withDuration: 0.3, animations: {
                        overlay.alpha = 0.0
                    }, completion: { (_) in
                        overlay.removeFromSuperview()
                    })
                }
                else{
                    overlay.removeFromSuperview()
                }
            }
        }
        
        public func addOverlayView(overlayView:UIView , tag:Int=overlayTag,withAnimation:Bool=true){
            if let _=self.viewWithTag(tag){
                return
            }
            
            overlayView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
            overlayView.center = self.center
            overlayView.tag=tag
            overlayView.isUserInteractionEnabled=true
            overlayView.alpha=0.0
            
            self.addSubview(overlayView)
            self.bringSubviewToFront(overlayView)
            
            
            overlayView.matchBoundsToParent()
            
            if withAnimation{
                UIView.animate(withDuration: 0.3) {
                    overlayView.alpha = 1.0
                }
            }
            else{
                overlayView.alpha = 1.0
            }
        }
        
        public func addOverlayWithIndicatorAndText(bgColor:UIColor = UIColor.black.withAlphaComponent(0.5) ,
                                                   tag:Int=overlayTag,
                                                   withAnimation:Bool=true,
                                                   showIndicator:Bool=false,
                                                   indicatorStyle:UIActivityIndicatorView.Style = .whiteLarge,
                                                   indicatorColor:UIColor = .white ,
                                                   text:String?=nil,
                                                   textColor:UIColor = .white){
            
            
            let overlay = UIView(frame: self.bounds)
            overlay.backgroundColor = bgColor
            
            if showIndicator||text.isNotNilAndEmpty{
                
                let stackView = UIStackView()
                stackView.axis = .vertical
                stackView.distribution = .equalSpacing
                stackView.alignment = .center
                stackView.spacing = 16
                
                //indicator
                var indicator:UIActivityIndicatorView?
                if showIndicator{
                    indicator = UIActivityIndicatorView()
                    indicator!.style = indicatorStyle
                    indicator!.color = indicatorColor
                    indicator!.startAnimating()
                    stackView.addArrangedSubview(indicator!)
                }
                
                
                
                //label
                if let textString = text {
                    let label = UILabel()
                    label.text = textString
                    label.textColor = textColor
                    label.numberOfLines = 0
                    label.font=label.font.withSize(15.0)
                    label.sizeToFit()
                    stackView.addArrangedSubview(label)
                }
                
                overlay.addSubview(stackView)
                stackView.cenetrInParent()
            }
            
            
            
            addOverlayView(overlayView: overlay,tag: tag,withAnimation: withAnimation)
            
            
            //        if withAnimation{
            //            UIView.animate(withDuration: 0.3) {
            //                overlay.alpha = 1.0
            //            }
            //        }
            //        else{
            //            overlay.alpha = 1.0
            //        }
            
        }
        
        public  func addOverlayWithIndicator(bgColor:UIColor = UIColor.black.withAlphaComponent(0.5) ,
                                             tag:Int=overlayTag,
                                             withAnimation:Bool=true,
                                             showIndicator:Bool=true,
                                             indicatorStyle:UIActivityIndicatorView.Style = .whiteLarge,
                                             indicatorColor:UIColor = .white ){
            addOverlayWithIndicatorAndText(bgColor: bgColor, tag: tag, withAnimation: withAnimation, showIndicator: showIndicator, indicatorStyle: indicatorStyle, indicatorColor: indicatorColor)
        }
        
        public  func addOverlayWithText(bgColor:UIColor = UIColor.black.withAlphaComponent(0.5) ,
                                        tag:Int=overlayTag,
                                        withAnimation:Bool=true,
                                        text:String?=nil,
                                        textColor:UIColor = .white){
            addOverlayWithIndicatorAndText(bgColor: bgColor,tag: tag,withAnimation: withAnimation,text:text,textColor:textColor)
        }
        
        public  func addOverlay(bgColor:UIColor = UIColor.black.withAlphaComponent(0.5) ,
                                tag:Int=overlayTag,
                                withAnimation:Bool=true){
            addOverlayWithIndicatorAndText(bgColor: bgColor,tag: tag,withAnimation: withAnimation)
        }
        
    }
    
    
    
    //-----BlurEffect
    public let blurEffectTag=19431
    extension UIView{
        public  func addBlurEffect(_ style: UIBlurEffect.Style = .light , withAnimation:Bool=true,tag:Int=blurEffectTag) {
            
            let bounds = self.bounds
            
            let blurEffect = UIBlurEffect(style: style)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            visualEffectView.tag=tag
            visualEffectView.isUserInteractionEnabled = true
            visualEffectView.frame = bounds
            visualEffectView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
            self.addSubview(visualEffectView)
            if withAnimation{
                visualEffectView.alpha=0.0
                UIView.animate(withDuration: 0.3, animations: {
                    visualEffectView.alpha=1.0
                })
            }
        }
        
        
        public func removeBlurEffect(withAnimation:Bool=true,tag:Int=blurEffectTag){
            if let effect=self.viewWithTag(tag){
                
                if withAnimation{
                    UIView.animate(withDuration: 0.3, animations: {
                        effect.alpha = 0.0
                    }, completion: { (_) in
                        effect.removeFromSuperview()
                    })
                }
                else{
                    effect.removeFromSuperview()
                }
            }
        }
    }
    
    
    //----- layer
    struct AssociatedKeys {
        static var cornerRadius: CGFloat = 0
        static var borderWidth: CGFloat = 0
        static var borderColor: UIColor?  = nil
        static var shadowRadius: CGFloat = 0
    }
    extension UIView {
        
        
        @IBInspectable
        public var cornerRadius: CGFloat {
            get {
                guard let value = objc_getAssociatedObject(self, &AssociatedKeys.cornerRadius) as? CGFloat else {
                    return 0
                }
                return value
            }
            set{
                objc_setAssociatedObject(self, &AssociatedKeys.cornerRadius, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0 && shadowRadius==0
            }
        }
        
        @IBInspectable
        public var borderWidth: CGFloat {
            get {
                guard let value = objc_getAssociatedObject(self, &AssociatedKeys.borderWidth) as? CGFloat else {
                    return 0
                }
                return value
                
            }
            set {
                objc_setAssociatedObject(self, &AssociatedKeys.borderWidth, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                layer.borderWidth = newValue
            }
        }
        
        @IBInspectable
        public var borderColor: UIColor? {
            get {
                guard let value = objc_getAssociatedObject(self, &AssociatedKeys.borderWidth) as? UIColor else {
                    return nil
                }
                return value
            }
            set {
                objc_setAssociatedObject(self, &AssociatedKeys.borderColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                layer.borderColor = newValue?.cgColor
            }
        }
        
        
        
        @IBInspectable
        public var shadowRadius: CGFloat {
            get {
                guard let value = objc_getAssociatedObject(self, &AssociatedKeys.shadowRadius) as? CGFloat else {
                    return 0
                }
                return value
            }
            set {
                objc_setAssociatedObject(self, &AssociatedKeys.shadowRadius, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                layer.masksToBounds = newValue==0
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 1)
                layer.shadowOpacity = 0.3
                layer.shadowRadius = newValue
            }
        }
        
        
    }
    
    
    //----- size
    
    public extension UIView{
        
       var width: CGFloat {
            get { return self.frame.size.width }
            set { self.frame.size.width = newValue }
        }
        
       var height: CGFloat {
            get { return self.frame.size.height }
            set { self.frame.size.height = newValue }
        }
        
        var top: CGFloat {
            get { return self.frame.origin.y }
            set { self.frame.origin.y = newValue }
        }
        var right: CGFloat {
            get { return self.frame.origin.x + self.width }
            set { self.frame.origin.x = newValue - self.width }
        }
        var bottom: CGFloat {
            get { return self.frame.origin.y + self.height }
            set { self.frame.origin.y = newValue - self.height }
        }
        var left: CGFloat {
            get { return self.frame.origin.x }
            set { self.frame.origin.x = newValue }
        }
        
        var centerX: CGFloat{
            get { return self.center.x }
            set { self.center = CGPoint(x: newValue,y: self.centerY) }
        }
        var centerY: CGFloat {
            get { return self.center.y }
            set { self.center = CGPoint(x: self.centerX,y: newValue) }
        }
        
        var origin: CGPoint {
            set { self.frame.origin = newValue }
            get { return self.frame.origin }
        }
        var size: CGSize {
            set { self.frame.size = newValue }
            get { return self.frame.size }
        }
    }
    
    
    
    extension UIView{
        public var isVisible:Bool{
            set{
                self.isHidden = !newValue
            }
            get{
                return !self.isHidden
            }
        }
        
        
        var isVisibleOnScreen : Bool {
            func isVisible(view: UIView, inView: UIView?) -> Bool {
                guard let inView = inView else { return true }
                let viewFrame = inView.convert(view.bounds, from: view)
                if viewFrame.intersects(inView.bounds) {
                    return isVisible(view: view, inView: inView.superview)
                }
                return false
            }
            return isVisible(view: self, inView: self.superview)
        }
        
        
        public  var parentViewController:UIViewController?{
            get{
                var responder: UIResponder? = self
                while !(responder is UIViewController) {
                    responder = responder?.next
                    if nil == responder {
                        break
                    }
                }
                
                return responder as? UIViewController
            }
        }
        
        public  func setVisibility( visible:Bool , withAnimation: Bool = false, animationDuration: TimeInterval = 0.2){
            if visible{
                show(withAnimation: withAnimation, animationDuration: animationDuration)
            }
            else{
                hide(withAnimation: withAnimation, animationDuration: animationDuration)
            }
        }
        
        public  func hide(withAnimation: Bool = false, animationDuration: TimeInterval = 0.2) {
            
            if isHidden{
                return
            }
            
            if withAnimation {
                
                fadeOut(withDuration: animationDuration, completion: { [weak self] (_) in
                    self?.isHidden=true
                })
                
            }
            else{
                isHidden=true
            }
        }
        
        public func show(withAnimation: Bool = false, animationDuration: TimeInterval = 0.2) {
            
            if isVisible{
                return
            }
            
            isHidden=false
            if withAnimation{
                fadeIn(withDuration: animationDuration, completion: nil)
            }
            
        }
    }
    
    
    
    
    
    //MARK:- Button
    extension UIButton{
        public func setTextColor(_ color:UIColor){
            self.setTitleColor(color, for: UIControl.State.normal)
        }
        
        public func makeLink(title:String,titleColor:UIColor,textSize:CGFloat){
            let yourAttributes : [NSAttributedString.Key: Any] = [
                NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: textSize),
                NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : titleColor,
                NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue) : NSUnderlineStyle.single.rawValue]
            
            let attributeString = NSMutableAttributedString(string: title,
                                                            attributes: yourAttributes)
            self.setAttributedTitle(attributeString, for: UIControl.State.normal)
        }
        
    }
    
    extension UIButton {
        public var fontSize:CGFloat?{
            get{
                if let label=self.titleLabel{
                    return label.fontSize
                }
                return nil
            }
            set{
                if self.titleLabel != nil, let newValue=newValue{
                    self.titleLabel!.fontSize=newValue
                }
            }
        }
    }
    
    
    //MARK:- Label
    extension UILabel {
        public var numberOfVisibleLines: Int {
            guard let text=self.text else {
                return 0
            }
            
            let rect: CGRect = text.boundingRect(with: CGSize(width: self.bounds.width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            return Int(ceil(rect.size.height / font.lineHeight))
        }
        
    }
    extension UILabel {
        public  var fontSize:CGFloat{
            get{
                return self.font.pointSize
            }
            set{
                self.font=self.font.withSize(newValue)
            }
        }
    }
    
    
    //MARK:- TextView
    extension UITextView {
        public var fontSize:CGFloat?{
            get{
                if let font=self.font{
                    return font.pointSize
                }
                return nil
            }
            set{
                if self.font != nil, let newValue=newValue{
                    self.font=self.font!.withSize(newValue)
                }
            }
        }
    }
    
    
    //MARK:- TextField
    extension UITextField{
        public  var fontSize:CGFloat?{
            get{
                if let font=self.font{
                    return font.pointSize
                }
                return nil
            }
            set{
                if self.font != nil, let newValue=newValue{
                    self.font=self.font!.withSize(newValue)
                }
            }
        }
    }
    
    
    
    //MARK:- Navigation
    extension UINavigationBar{
        
        private struct StoredProperties{
            static var  isHairlineHidden: Bool = false
            static var isBackgroundTransparent: Bool = false
        }
        
        public var hairline:UIImageView?{
            get{
                for parent in self.subviews {
                    for childView in parent.subviews {
                        if childView is UIImageView && childView.bounds.size.width == self.frame.size.width {
                            return childView as? UIImageView
                        }
                    }
                }
                return nil
            }
        }
        
        public  var isHairlineHidden:Bool{
            get{
                return objc_getAssociatedObject(self, &StoredProperties.isHairlineHidden) as! Bool
            }
            set{
                
                objc_setAssociatedObject(self, &StoredProperties.isHairlineHidden, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                if newValue{
                    self.shadowImage = UIImage()
                }
                else{
                    self.shadowImage = UINavigationBar.appearance().shadowImage
                }
            }
            
        }
        
        
        public var isBackgroundTransparent:Bool{
            get{
                return objc_getAssociatedObject(self, &StoredProperties.isBackgroundTransparent) as! Bool
            }
            set{
                
                objc_setAssociatedObject(self, &StoredProperties.isBackgroundTransparent, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                if newValue{
                    self.setBackgroundImage(UIImage(), for:.default)
                }
                else{
                    setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:.default)
                }
            }
            
        }
    }
    
    extension UINavigationController {
        
        public func presentTransparentNavigationBar() {
            navigationBar.isBackgroundTransparent=true
            navigationBar.isTranslucent = true
            navigationBar.isHairlineHidden=true
            //setNavigationBarHidden(false, animated:true)
        }
        
        public func hideTransparentNavigationBar() {
            //setNavigationBarHidden(true, animated:false)
            navigationBar.isBackgroundTransparent=false
            navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
            navigationBar.isHairlineHidden=false
        }
        
    }
    
    extension UINavigationController {
        
        var currenViewController:UIViewController?{
            return self.viewControllers.last
        }
        
        var previousViewController:UIViewController?{
            if self.viewControllers.count >= 2 {
                let n = self.viewControllers.count
                return self.viewControllers[n-2]
            }
            return nil
        }
        
    }
    
    extension UINavigationItem
    {
        public func appendRightBarImageButton(_ image:UIImage, size:CGSize=CGSize(width:25,height:25))->UIBarButtonItem{
            var barButtons = rightBarButtonItems ?? []
            
            let btn: UIButton = UIButton(type: UIButton.ButtonType.custom)
            btn.setImage(image, for: [])
            btn.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            let barButton = UIBarButtonItem(customView: btn)
            
            barButtons.append(barButton)
            
            rightBarButtonItems=barButtons
            
            return barButton
        }
        
        
        public func appendLeftBarImageButton(_ image:UIImage, size:CGSize=CGSize(width:40,height:30))->UIBarButtonItem{
            var barButtons = leftBarButtonItems ?? []
            
            let btn: UIButton = UIButton(type: UIButton.ButtonType.custom)
            btn.setImage(image, for: [])
            btn.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            let barButton = UIBarButtonItem(customView: btn)
            
            barButtons.append(barButton)
            
            leftBarButtonItems=barButtons
            
            return barButton
        }
    }
    
    
    //MARK:- ViewController
    
    fileprivate struct UIViewControllerAssociatedKeys {
        static var originalSize: CGSize = CGSize.zero
        static var orientation: UIInterfaceOrientationMask =  appDelegateInstance.appDefaultOrientation
    }
    extension UIViewController{
        
        public var orientation:UIInterfaceOrientationMask{
            get{
                return (objc_getAssociatedObject(self, &UIViewControllerAssociatedKeys.orientation) as? UIInterfaceOrientationMask) ?? UIViewControllerAssociatedKeys.orientation
            }
            set{
                
                objc_setAssociatedObject(self, &UIViewControllerAssociatedKeys.orientation, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                switch newValue {
                case .portrait:
                    CurrentDevice.orientation = .portrait
                    break
                case .portraitUpsideDown:
                    CurrentDevice.orientation = .portraitUpsideDown
                    break
                case .landscapeLeft:
                    CurrentDevice.orientation = .landscapeLeft
                    break
                case .landscapeRight:
                    CurrentDevice.orientation = .landscapeRight
                    break
                default:
                    break
                }
            }
            
        }
        
        public  var statusBarHeight:CGFloat{
            get{
                return UIApplication.shared.statusBarFrame.height
            }
        }
        
        public var navigationBarHeight:CGFloat{
            get{
                return self.navigationController?.navigationBar.frame.height ?? 0
            }
        }
        
        public  var tabBarHeight:CGFloat{
            get{
                return self.tabBarController?.tabBar.frame.height ?? 0
            }
        }
        
        public  func setStatusBarVisibility(visible:Bool,animation:UIStatusBarAnimation = .fade){
            UIApplication.shared.setStatusBarHidden(!visible, with: animation)
        }
        
        public  func setBackButton(title:String?,icon:UIImage?){
            uiThread {
                if let icon = icon {
                    self.navigationController?.navigationBar.backIndicatorImage = icon
                    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = icon
                }
                
                if let title = title{
                    let customBackButton = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
                    self.navigationItem.backBarButtonItem = customBackButton
                }
            }
        }
        
        public var hideKeyboardOnTap:Bool{
            set{
                if newValue{
                    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
                    view.addGestureRecognizer(tap)
                }
            }
            get{
                return false
            }
        }
        
        
        @objc public func dismissKeyboard() {
            KeyboardHelper.dismissKeyboard(viewController: self)
        }
        
        @objc public func showKeyboard(responder: UIResponder) {
            KeyboardHelper.showKeyboard(responder: responder)
        }
        
        public  func resizeViewAccording(to keyboardNotification:Notification){
            
            if let keyboardSize = (keyboardNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                (keyboardNotification.name==UIResponder.keyboardWillShowNotification||keyboardNotification.name==UIResponder.keyboardWillHideNotification){
                
                var viewSize = CGSize.zero
                if let value = objc_getAssociatedObject(self, &UIViewControllerAssociatedKeys.originalSize) as? CGSize , value != CGSize.zero {
                    viewSize = value
                }
                else{
                    let width =  view.frame.width
                    let height =  view.frame.height
                    let size = CGSize(width: width < height ? width : height, height: height > width ? height : width)
                    objc_setAssociatedObject(self, &UIViewControllerAssociatedKeys.originalSize, size, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    viewSize = size
                }
                
                
                let originHeight = CurrentDevice.isLandescape ? viewSize.width : viewSize.height
                let newHeight = keyboardNotification.name==UIResponder.keyboardWillShowNotification ? (originHeight - keyboardSize.height) :  originHeight
                
                delay(0, block: {
                    self.view.frame = CGRect(x: self.view.frame.origin.x,
                                             y: self.view.frame.origin.y,
                                             width: self.view.frame.width,
                                             height: newHeight)
                })
                
            }
        }
        
        public  func reloadViewFromNib() {
            let parent = view.superview
            view.removeFromSuperview()
            view = nil
            parent?.addSubview(view) // This line causes the view to be reloaded
        }
        
        
        public  func dismissCompatible(animated: Bool = true){
            if let navVC=self.navigationController{
                navVC.popViewController(animated: animated)
            }
            else{
                self.dismiss(animated: animated, completion: nil)
            }
        }
    }
    
    
    //MARK:- ScrollView
    extension UIScrollView{
        public func scrollToBottom(animated: Bool=true){
            self.scrollRectToVisible(CGRect(x: CGFloat(self.contentSize.width - 1), y: CGFloat(self.contentSize.height - 1), width: CGFloat(1), height: CGFloat(1)), animated: animated)
        }
        
        public  func scrollToTop(animated: Bool=true){
            self.scrollRectToVisible(CGRect(x: CGFloat(self.contentSize.width - 1), y: CGFloat(1), width: CGFloat(1), height: CGFloat(1)), animated: animated)
        }
    }
    
    extension UIPageViewController{
        public  var scrollView:UIScrollView?{
            get{
                for view in self.view.subviews {
                    if (view is UIScrollView) {
                        return view as? UIScrollView
                    }
                }
                return nil
            }
        }
        
    }
    
    extension UIScrollView{
        public func setPadding(_ top: CGFloat,  _ bottom: CGFloat){
            self.scrollIndicatorInsets = UIEdgeInsets.init(top: top, left: 0, bottom: bottom, right: 0)
            self.contentInset=UIEdgeInsets.init(top: top, left: 0, bottom: bottom, right: 0)
        }
    }
    
    
    extension UIScrollView{
        public func setRefreshControlCompatible(refreshControl:UIRefreshControl){
            if #available(iOS 10.0, *) {
                self.refreshControl = refreshControl
            } else {
                self.addSubview(refreshControl)
            }
        }
    }
    
    
    //MARK:- SearchBar
    extension UISearchBar{
        public var textField:UITextField?{
            get{
                return self.value(forKey: "searchField") as? UITextField
            }
        }
        
        public var btnCancel:UIButton?{
            get{
                return self.value(forKey: "cancelButton") as? UIButton
            }
        }
    }
    
    
    //MARK:- TableView
    extension UITableView{
        
    }
    
    
    //MARK:- UICollectionView
    extension UICollectionView{
        
        
        
    }
    
    
    
    
    //MARK:- UIActivityIndicator
    extension UIActivityIndicatorView{
        public var visibleAndAnimated:Bool{
            set{
                isHidden = !newValue
                
                if newValue && !isAnimating{
                    startAnimating()
                }
                    
                else  if !newValue && !isAnimating{
                    stopAnimating()
                }
            }
            get{
                return !isHidden && isAnimating
            }
        }
    }
    
    
    //MARK:- UIPickerView
    extension UIPickerView {
        public func hideSelectionIndicators(top:Bool=true,bottom:Bool=true) {
            if top {
                subviews[safe: 1]?.isHidden = true
            }
            if bottom {
                subviews[safe: 2]?.isHidden = true
            }
            
        }
    }
    
    
