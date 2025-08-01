//
//  UserProvider.swift
//  RandomUsers
//
//  Created by Alejandro Guerra, DSpot on 9/13/21.
//

import Foundation
import Moya

public final class UserProvider {
    
    private let service: MoyaProvider<UserServices>
    
    init(service: MoyaProvider<UserServices>) {
        self.service = service
    }
}

// MARK: - UserProvider
extension UserProvider: UserProviderProtocol {
    
    public func listOfUsers(userCount: Int) {
        service.request(.userList(userCount: userCount)) { result in
            switch result {
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
