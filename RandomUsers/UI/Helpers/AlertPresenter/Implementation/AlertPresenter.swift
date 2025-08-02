//
//  AlertPresenter.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import UIKit

public final class AlertPresenter {
    
    weak var presentedViewController: UIViewController?
}

// MARK: - AlertPresenterProtocol
extension AlertPresenter: AlertPresenterProtocol {
    
    public func presentAlert(
        with message: String,
        action: @escaping () -> Void
    ) {
        let alert = UIAlertController(
            title: "Alert",
            message: message,
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(
            title: "Retry",
            style: .default
        ) { _ in
            action()
        }
        
        alert.addAction(retryAction)
        
        presentedViewController?.present(
            alert,
            animated: true,
            completion: nil
        )
    }
}
