//
//  UserListViewController.swift
//  RandomUsers
//
//  Created by Alejandro Guerra, DSpot on 9/13/21.
//

import Foundation
import UIKit

class UserListViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func navigateToSearchUser(){
//        let searchUserVC = SearchUsersViewController()
//        let vc = UINavigationController.init(rootViewController: searchUserVC)
//        present(vc, animated: true)
    }
    
    fileprivate func printMessage(){
        print("Search completed delegate")
    }
}
