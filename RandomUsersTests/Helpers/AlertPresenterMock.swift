//
//  AlertPresenterMock.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import RandomUsers

final class AlertPresenterMock {
    
    var presentAlertRequestsCount = 0
}

// MARK: - AlertPresenterProtocol
extension AlertPresenterMock: AlertPresenterProtocol {
    
    func presentAlert(
        with message: String,
        action: @escaping () -> Void
    ) {
        presentAlertRequestsCount += 1
    }
}
