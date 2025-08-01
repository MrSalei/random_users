//
//  UserListViewModel.swift
//  RandomUsers
//
//  Created by Илья Салей on 1.08.25.
//

private struct Constants {
    static let USER_COUNT: Int = 50
}

public final class UserListViewModel {
    
    private let provider: UserProviderProtocol
    
    public init(provider: UserProviderProtocol) {
        self.provider = provider
    }
    
    public func loadUsers() {
        provider.listOfUsers(userCount: Constants.USER_COUNT)
    }
}
