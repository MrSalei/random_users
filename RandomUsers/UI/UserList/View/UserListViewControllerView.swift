//
//  UserListViewControllerView.swift
//  RandomUsers
//
//  Created by Илья Салей on 1.08.25.
//

import UIKit

public final class UserListViewControllerView: UIView {
    
    public let usersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: String(describing: UserTableViewCell.self))
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override public init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        layer.isDoubleSided = false
        layoutTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LAYOUT HELPERS
extension UserListViewControllerView {
    
    private func layoutTableView() {
        addSubview(usersTableView)
        
        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            usersTableView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            usersTableView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            usersTableView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}
