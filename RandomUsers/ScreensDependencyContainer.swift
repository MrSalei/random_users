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
        
        let viewModel = UserListViewModel(
            provider: provider
        )
        
        let vc = UserListViewController(
            viewModel: viewModel
        )
        
        return vc
    }
}
