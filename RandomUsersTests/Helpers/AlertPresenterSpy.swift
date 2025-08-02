//
//  AlertPresenterSpy.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import RandomUsers

final class AlertPresenterSpy {
    
    private var action: (() -> Void)?
}

// MARK: - Helpers
extension AlertPresenterSpy {
    
    func simulateActionButtonTap() {
        action?()
    }
}

// MARK: - AlertPresenterProtocol
extension AlertPresenterSpy: AlertPresenterProtocol {
    
    func presentAlert(
        with message: String,
        action: @escaping () -> Void
    ) {
        self.action = action
    }
}
