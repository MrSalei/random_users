//
//  UserListViewController.swift
//  RandomUsers
//
//  Created by Alejandro Guerra, DSpot on 9/13/21.
//

import Foundation
import UIKit

public final class UserListViewController: UIViewController {
    
    private let viewModel: UserListViewModel
    private let contentView = UserListViewControllerView()
    
    public init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        view = contentView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadUsers()
    }
}

// MARK: - NAVIGATION HELPERS
extension UserListViewController {
    
    func navigateToSearchUser() {
//        let searchUserVC = SearchUsersViewController()
//        let vc = UINavigationController.init(rootViewController: searchUserVC)
//        present(vc, animated: true)
    }
}

// MARK: - SEARCH DELEGATE
extension UserListViewController {
    
    fileprivate func printMessage(){
        print("Search completed delegate")
    }
}
