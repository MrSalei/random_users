//
//  UserProviderProtocol.swift
//  RandomUsers
//
//  Created by Alejandro Guerra, DSpot on 9/13/21.
//

import Foundation
import Moya

public protocol UserProviderProtocol {
    func listOfUsers(userCount: Int)
}
