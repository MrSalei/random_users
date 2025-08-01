//
//  UserServices.swift
//  RandomUsers
//
//  Created by Alejandro Guerra, DSpot on 9/13/21.
//

import Foundation
import Moya

enum UserServices {
    case userList(userCount: Int)
}

extension UserServices: TargetType {
    var baseURL: URL {
        return URL(string: "https://randomuser.me/api")!
    }

    var path: String {
        return "/"
    }

    var method: Moya.Method {
        .get
    }

    var sampleData: Data {
        switch self {
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }

    var task: Task {
        switch self {
        case let .userList(userCount):
            return .requestParameters(parameters: ["results": userCount], encoding:  URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        nil
    }

}
