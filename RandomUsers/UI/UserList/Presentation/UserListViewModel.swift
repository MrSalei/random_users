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
    
    private(set) var storedUsers = [RandomUser]()
    
    public var usersAreLoading = true
    
    private let provider: UserProviderProtocol
    private let alertPresenter: AlertPresenterProtocol
    
    public init(
        provider: UserProviderProtocol,
        alertPresenter: AlertPresenterProtocol
    ) {
        self.provider = provider
        self.alertPresenter = alertPresenter
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
                
                self?.displayAlert(
                    with: userError.description
                )
            }
            
            self?.usersAreLoading = false
        }
    }
}

// MARK: - HELPERS
extension UserListViewModel {
    
    private func displayAlert(
        with message: String
    ) {
        alertPresenter.presentAlert(
            with: message
        ) { [weak self] in
            self?.loadUsers()
        }
    }
}
