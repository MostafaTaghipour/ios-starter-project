//  ___FILEHEADER___

import UIKit
import STPopup
import Common

class Navigator : SuperRouterStatic{
    
    private class func showAsPopup(currentVC:UIViewController,popupVC:UIViewController){
        let popup=STPopupController(rootViewController: popupVC)
        popup.backgroundView?.addBlurEffect(.extraLight)
        popup.containerView.layer.cornerRadius = R.dimen.popupCorenerRadius()
        popup.containerView.borderColor = .lightGray
        popup.containerView.borderWidth = 0.5
        popup.present(in: currentVC)
    }
    
    
    class func start(){
        main()
    }
    
    class func main(){
        window?.rootViewController = MainTBC()
    }
    
    class func logout(){
        //todo immplement logout
    }
}



