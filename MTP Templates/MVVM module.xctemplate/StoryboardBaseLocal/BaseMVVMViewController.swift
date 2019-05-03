//  ___FILEHEADER___

import UIKit
import SwiftEventBus
import RxSwift

class BaseMVVMViewController: BaseViewController   {

    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeEvents()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeEvents()
    }
    
    
    
    //MARK:- Events
    private func subscribeEvents(){
        SwiftEventBus.onMainThread(self, name: BusEvents.message.rawValue) {[weak self](notification) in
            guard let event = notification?.object as? MessageEvent else { return  }
            
            self?.onMessageEvent(event: event)
        }
        SwiftEventBus.onMainThread(self, name: BusEvents.navigation.rawValue) {[weak self] (notification) in
            guard let event = notification?.object as? NavigationEvent else { return  }
            
            self?.onNavigationEvent(event: event)
        }
        SwiftEventBus.onMainThread(self, name: BusEvents.httpError.rawValue) {[weak self] (notification) in
            guard let error = notification?.object as? HttpError else { return  }
            self?.onHttpError(httpError: error)
        }
        SwiftEventBus.onMainThread(self, name: BusEvents.dismiss.rawValue) { [weak self] (notification) in
            self?.onDismissEvent()
        }
        
        SwiftEventBus.onMainThread(self, name: BusEvents.noInternetAccess.rawValue) { [weak self] (notification) in
            self?.onLostInternetConnection()
        }
    }
    
    private func unsubscribeEvents(){
        SwiftEventBus.unregister(self, name:BusEvents.message.rawValue)
        SwiftEventBus.unregister(self, name: BusEvents.navigation.rawValue)
        SwiftEventBus.unregister(self, name:  BusEvents.httpError.rawValue)
        SwiftEventBus.unregister(self, name:BusEvents.noInternetAccess.rawValue)
        SwiftEventBus.unregister(self, name:BusEvents.dismiss.rawValue)
    }
    
    open func onNavigationEvent(event:NavigationEvent){
        //        if event.destination is AuthVC.Type{
        //            Navigator.logout()
        //        }
        //todo
    }
    
    open func onDismissEvent(){
        dismissCompatible()
    }
    
    open func onMessageEvent(event:MessageEvent){
        event.show()
    }
    
    open func onHttpError(httpError:HttpError){
        errorMessage(body: httpError.localizedDescription)
    }
    
    private func onLostInternetConnection(){
        statusMessage(title: R.string.errors.error_internet_connection(), style: .error)
    }
}
