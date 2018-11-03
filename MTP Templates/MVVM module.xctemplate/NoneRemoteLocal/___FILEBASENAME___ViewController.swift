//  ___FILEHEADER___

import UIKit
import RxSwift

class ___FILEBASENAMEASIDENTIFIER___ : BaseViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    let disposeBag=DisposeBag()
    
    var viewModel:___VARIABLE_productName:identifier___ViewModel?{
        didSet{
            guard let vm = viewModel else { return  }
            onViewModelReady(viewModel: vm)
        }
    }
    
    override func onReady() {
        self.title = "___VARIABLE_productName:identifier___"
        setupView()
    }
    
    func setupView(){
        
    }
}
