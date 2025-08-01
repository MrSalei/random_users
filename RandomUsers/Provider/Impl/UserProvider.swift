//
//  UserProvider.swift
//  RandomUsers
//
//  Created by Alejandro Guerra, DSpot on 9/13/21.
//

import Foundation
import Moya

class UserProvider: UserProviderProtocol {
    private let service: MoyaProvider<UserServices>
    
    init(service: MoyaProvider<UserServices>) {
        self.service = service
    }
    
    func listOfUsers(userCount: Int) {
        service.request(.userList(userCount: userCount)) { result in
            switch result{
            case .success(let response):
                //                parse and return data
                break
            case .failure(let error):
                //                handle request error
                break
            }
        }
    }
    
    
}
