//
//  ScreensDependencyContainer.swift
//  RandomUsers
//
//  Created by Илья Салей on 1.08.25.
//

import UIKit
import Moya

final class ScreensDependencyContainer {
    
    init() {}
    
    func createRootViewController() -> UIViewController {
        let service = MoyaProvider<UserServices>()
        
        let provider = UserProvider(
            service: service
        )
        
        let alertPresenter = AlertPresenter()
        
        let viewModel = UserListViewModel(
            provider: provider,
            alertPresenter: alertPresenter
        )
        
        let vc = UserListViewController(
            viewModel: viewModel
        )
        
        alertPresenter.presentedViewController = vc
        
        return vc
    }
}
