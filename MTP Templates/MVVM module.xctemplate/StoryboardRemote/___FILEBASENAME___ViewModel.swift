//  ___FILEHEADER___

import UIKit
import RxSwift

class ___FILEBASENAMEASIDENTIFIER___Imp: BaseViewModel , ___FILEBASENAMEASIDENTIFIER___{
    
    private var repo : ___VARIABLE_productName:identifier___Repo!
    let text = Variable<String?> (nil)

    
    init(repo : ___VARIABLE_productName:identifier___Repo) {
        super.init()
        self.repo = repo
    }
    

    func doSomething() {
        
        guard let text = self.text.value , text.isNotEmpty else {
            postEvent(.message, params:  MessageEvent( body: R.string.common.text_is_empty() , style: .error, onTop:true))
            return
        }
 
       successMessage(body: text)
    }

}
