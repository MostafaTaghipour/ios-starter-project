//  ___FILEHEADER___

import UIKit
import RxSwift
import RxCocoa
import Common


extension ___VARIABLE_productName:identifier___ViewController  {
    
    func onViewModelReady(viewModel: ___VARIABLE_productName:identifier___ViewModel) {
        
        (textField.rx.text <-> viewModel.text)
            .disposed(by: disposeBag)
        
        
        submitButton
        .rx
        .tap
        .bind(onNext:viewModel.doSomething)
        .disposed(by: disposeBag)
    }
    
}
