//  ___FILEHEADER___

import Foundation
import RxSwift
import SwiftEventBus
import Common
import SwinjectAutoregistration

class BaseViewModel : NSObject {
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    weak var appDelegate: AppDelegate? = inject()
    
    var noInternetAccess:Bool{
        get{
            
            guard let appDelegate = appDelegate else { return false }
            
            let connectToInternet = appDelegate.isConnectToInternet
            
            if !connectToInternet{
                postEvent(.noInternetAccess)
            }
            
            return !connectToInternet
        }
    }
    
    var isUserSessionValid:Bool{
        return credentionalsRepo.isSessionValid
    }

    let credentionalsRepo : CredentionalsRepo = inject()

    override init() {
        super.init()
        validateSession()
    }
    
    
    func postEvent(_ event: BusEvents, params: AnyObject? = nil){
        SwiftEventBus.post(event.rawValue, sender: params)
    }
    
    open func validateSession(){
//        if !isUserSessionValid{
//            postEvent(.navigation, params: NavigationEvent(destination: AuthVC.self))
//        }
        //todo
    }
    
    func hasError(error: Error?)->Bool{
        if let error = error{
            postEvent(.httpError, params: error as? HttpError)
            return true
        }
        
        return false
    }
    
    
}

