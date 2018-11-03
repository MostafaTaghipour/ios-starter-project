//
//  UIPageView.swift
//  common
//
//  Created by Remote User on 12/17/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit

public protocol PageViewDelegate:class {
    func pageView(onChanged index:Int,page:UIViewController)
}

public class PageView: UIView {
    
    @IBInspectable public var animated:Bool=true
    @IBInspectable public var Infinite:Bool=false
    @IBInspectable public var swipable:Bool=true{
        didSet{
            self.childViewController.scrollView?.isScrollEnabled=swipable
        }
    }
    //    @IBInspectable var bounces:Bool=true{
    //        didSet{
    //          self.childViewController.scrollView?.bounces = false
    //        }
    //    }
    
    
    private weak var _parentViewController:UIViewController?
    
   public lazy var childViewController: UIPageViewController = {  [unowned self] in
        let controller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self._parentViewController?.addChild(controller)
        self.addSubview(controller.view)
        
        controller.view.frame = self.bounds
        controller.view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        controller.scrollView?.backgroundColor = .clear
        controller.view.backgroundColor = .clear
        
        controller.didMove(toParent: self._parentViewController)
        
        return controller
        }()
    
    
    public weak var delegate:PageViewDelegate?
    public weak var pageControl:UIPageControl?
    
    
    public var pages = [UIViewController](){
        didSet{
            currentPage=0
            pageControl?.numberOfPages = numberOfPages
        }
    }
    
   public var numberOfPages:Int{
        return pages.count
    }
    
    private var _currentPage = -1
   public var currentPage:Int{
        get{
            return _currentPage
        }
        set{
            goToPage(index: newValue)
        }
    }
    
    private var repeate:Bool = false
    fileprivate var timer: Timer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        self._parentViewController=self.parentViewController
        self.childViewController.dataSource = self
        self.childViewController.delegate = self
        
    }
    
    deinit {
        self.disableAutoScroll()
    }
    
   public func enableAutoScroll(timeInterval:TimeInterval = 5){
        self.repeate=true
        guard self.timer == nil else {
            return
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                          target: self,
                                          selector: #selector(self.nextPage),
                                          userInfo: nil, repeats: true)
    }
    
   public func disableAutoScroll(){
        guard self.timer == nil else {
            return
        }
        
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc public func nextPage(){
        if _currentPage == (numberOfPages-1) && repeate{
            goToPage(index:0)
        }
        else{
            goToPage(index: _currentPage+1)
        }
    }
    
   public func previousPage(){
        if _currentPage == 0 && repeate{
            goToPage(index:(numberOfPages-1))
        }
        else{
            goToPage(index: _currentPage-1)
        }
    }
    
    private  func goToPage(index:Int){
        if index<0||index > (numberOfPages-1) || currentPage==index{
            return
        }
        
        
        let forwardDirection:UIPageViewController.NavigationDirection = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .reverse : .forward
        let reverseDirection:UIPageViewController.NavigationDirection = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .forward : .reverse
        
        var direction:UIPageViewController.NavigationDirection = currentPage>index ? reverseDirection : forwardDirection
        if currentPage == numberOfPages-1 && index==0 && Infinite{
            direction = forwardDirection
        }
        if currentPage == 0 && index == numberOfPages-1  && Infinite{
            direction = reverseDirection
        }
        
        let newPage=setupNewPage(index: index)
        childViewController.setViewControllers([newPage], direction: direction, animated: self.animated, completion: nil)
        
    }
    
    private func setupNewPage(index:Int)->UIViewController{
        _currentPage=index
        
        let newPage=pages[index]
        
        delegate?.pageView(onChanged: index, page: newPage)
        pageControl?.currentPage=index
        
        return newPage
    }
    
}



extension PageView:UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    
   public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        let currentIndex = pages.index(of: viewController)
        
        if(currentIndex==NSNotFound){
            return nil
        }
        
        if(currentIndex==0){
            return  Infinite ? pages[numberOfPages-1] : nil
        }
        
        
        let previousIndex = currentIndex!-1
        return pages[previousIndex]
    }
    
   public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)
        if currentIndex==NSNotFound{
            return nil
        }
        
        
        let nextIndex = currentIndex!+1
        if(nextIndex==numberOfPages){
            return Infinite ? pages.first : nil
        }
        
        
        return pages[nextIndex]
    }
    
    
    
   public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            
            
            let index =  pages.index(of: pageViewController.viewControllers![0])
            
            
            _ =  setupNewPage(index: index!)
            
        }
    }
    
    
    private func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return numberOfPages
    }
    
    private func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

