//
//  UserServices.swift
//  RandomUsers
//
//  Created by Alejandro Guerra, DSpot on 9/13/21.
//

import Foundation
import Moya

public enum UserServices {
    case userList(userCount: Int)
}

extension UserServices: TargetType {
    public var baseURL: URL {
        return URL(string: "https://randomuser.me/api")!
    }

    public var path: String {
        return "/"
    }

    public var method: Moya.Method {
        .get
    }

    public var sampleData: Data {
        switch self {
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }

    public var task: Task {
        switch self {
        case let .userList(userCount):
            return .requestParameters(parameters: ["results": userCount], encoding:  URLEncoding.queryString)
        }
    }

    public var headers: [String: String]? {
        nil
    }
}
