//
//  UserListViewModel.swift
//  RandomUsers
//
//  Created by Илья Салей on 1.08.25.
//

import Foundation
import Combine

private struct Constants {
    static let USER_COUNT: Int = 50
}

public final class UserListViewModel {
    
    private(set) var randomUsersLoadedSender = PassthroughSubject<Void, Never>()
    private(set) var errorSender = PassthroughSubject<String, Never>()
    
    private(set) var storedUsers = [RandomUser]()
    
    public var usersAreLoading = true
    
    private let provider: UserProviderProtocol
    
    public init(provider: UserProviderProtocol) {
        self.provider = provider
    }
    
    public func loadUsers() {
        usersAreLoading = true
        
        provider.listOfUsers(
            userCount: Constants.USER_COUNT
        ) { [weak self] result in
            switch result {
            case .success(let randomUsers):
                self?.storedUsers.append(
                    contentsOf: randomUsers
                )
                
                self?.randomUsersLoadedSender.send()
            case .failure(let error):
                guard let userError = error as? UserProvider.Errors else {
                    return
                }
                
                self?.errorSender.send(userError.description)
            }
            
            self?.usersAreLoading = false
        }
    }
}
