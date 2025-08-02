//
//  AlertPresenterProtocol.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import Foundation

public protocol AlertPresenterProtocol {
    func presentAlert(
        with message: String,
        action: @escaping () -> Void
    )
}
