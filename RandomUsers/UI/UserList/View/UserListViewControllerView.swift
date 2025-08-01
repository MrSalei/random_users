//
//  UserListViewControllerView.swift
//  RandomUsers
//
//  Created by Илья Салей on 1.08.25.
//

import UIKit

public final class UserListViewControllerView: UIView {
    
    override public init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        // TODO: - REMOVE
        backgroundColor = .green
        layer.isDoubleSided = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
