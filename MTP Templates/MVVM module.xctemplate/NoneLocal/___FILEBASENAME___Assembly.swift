//  ___FILEHEADER___

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

// todo: apply ___FILEBASENAMEASIDENTIFIER___ to AppAssembler
class ___FILEBASENAMEASIDENTIFIER___: Assembly {
    
    func assemble(container: Container) {
        
        container.autoregister(___VARIABLE_productName:identifier___DataSource.self,initializer: ___VARIABLE_productName:identifier___DataSourceImp.init).inObjectScope(.weak)
        container.autoregister(___VARIABLE_productName:identifier___Repo.self, initializer: ___VARIABLE_productName:identifier___RepoImp.init).inObjectScope(.weak)
        container.autoregister(___VARIABLE_productName:identifier___ViewModel.self, initializer: ___VARIABLE_productName:identifier___ViewModelImp.init)
        container.storyboardInitCompleted(___VARIABLE_productName:identifier___ViewController.self) { (r, c) in c.viewModel = r~> }
        
    }
    
}
