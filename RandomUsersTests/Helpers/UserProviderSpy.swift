//
//  UserProviderSpy.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import Foundation
import RandomUsers

final class UserProviderSpy {
    
    private(set) var userRequestCount = 0
    private var completion: ((Result<[RandomUsers.RandomUser], any Error>) -> Void)?
    
    private var decoratee: UserProviderProtocol?
    
    public init(
        decoratee: UserProviderProtocol? = nil
    ) {
        self.decoratee = decoratee
    }
}

// MARK: - Helpers
extension UserProviderSpy {
    
    func completeListOfUsersSuccessfully() {
        let users = prepareUsers()
        completion?(.success(users))
    }
    
    func completeListOfUsersWithFailure() {
        completion?(.failure(UserProvider.Errors.ClientError))
    }
    
    private func prepareUsers() -> [RandomUsers.RandomUser] {
        let coordinates = RandomUsers.RandomUser.Coordinates(
            latitude: "0.05",
            longitude: "0.04"
        )
        
        let user = RandomUsers.RandomUser(
            fullName: "someFullName",
            email: "someEmail",
            coordinates: coordinates,
            thumbnail: "someThumbnail"
        )
        
        let usersArray = Array(
            repeating: user,
            count: userRequestCount
        )
        
        return usersArray
    }
}

// MARK: - UserProviderProtocol
extension UserProviderSpy: UserProviderProtocol {
    
    func listOfUsers(
        userCount: Int,
        completion: @escaping (Result<[RandomUsers.RandomUser], any Error>) -> Void
    ) {
        decoratee?.listOfUsers(
            userCount: userCount,
            completion: completion
        )
        
        self.userRequestCount += userCount
        self.completion = completion
    }
}
