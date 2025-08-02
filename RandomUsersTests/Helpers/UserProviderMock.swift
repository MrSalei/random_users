//
//  UserProviderMock.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import RandomUsers

final class UserProviderMock {
    
    var listOfUsersRequestsCount = 0
}

// MARK: - UserProviderProtocol
extension UserProviderMock: UserProviderProtocol {
    
    func listOfUsers(userCount: Int, completion: @escaping (Result<[RandomUsers.RandomUser], any Error>) -> Void) {
        listOfUsersRequestsCount += 1
    }
}
