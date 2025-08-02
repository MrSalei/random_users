//
//  UserProvider.swift
//  RandomUsers
//
//  Created by Alejandro Guerra, DSpot on 9/13/21.
//

import Foundation
import Moya

public final class UserProvider {
    
    public enum Errors: Swift.Error {
        case DecodingError
        case ClientError
        case FailedRequest
        
        var description: String {
            switch self {
            case .DecodingError:
                "There was a problem decoding returned data"
            case .ClientError:
                "There was a problem in getting correct response"
            case .FailedRequest:
                "There was a problem with sending the request"
            }
        }
    }
    
    private let service: MoyaProvider<UserServices>
    
    init(service: MoyaProvider<UserServices>) {
        self.service = service
    }
}

// MARK: - UserProvider
extension UserProvider: UserProviderProtocol {
    
    public func listOfUsers(
        userCount: Int,
        completion: @escaping (Result<[RandomUser], Error>) -> Void
    ) {
        service.request(
            .userList(
                userCount: userCount
            )
        ) { result in
            switch result {
            case .success(let response):
                if (200...299).contains(response.statusCode) {
                    let data = response.data
                    
                    guard let result = try? JSONDecoder().decode(
                        RandomUserListResult.self,
                        from: data
                    ) else {
                        completion(
                            .failure(Errors.DecodingError)
                        )
                        
                        return
                    }
                    
                    completion(
                        .success(result.results)
                    )
                } else {
                    completion(
                        .failure(Errors.ClientError)
                    )
                }
            case .failure:
                completion(
                    .failure(Errors.FailedRequest)
                )
            }
        }
    }
}
