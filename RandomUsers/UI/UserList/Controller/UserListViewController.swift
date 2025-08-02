//
//  UserListViewController.swift
//  RandomUsers
//
//  Created by Alejandro Guerra, DSpot on 9/13/21.
//

import UIKit
import Combine

public final class UserListViewController: UIViewController {
    
    private let viewModel: UserListViewModel
    private let contentView = UserListViewControllerView()
    private var cancellables = Set<AnyCancellable>()
    
    public init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        view = contentView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setupDelegates()
        viewModel.loadUsers()
    }
}

// MARK: - SETUP HELPERS
extension UserListViewController {
    
    private func bindViewModel() {
        viewModel.randomUsersLoadedSender
            .receive(
                on: DispatchQueue.main
            )
            .sink { [weak self] in
                self?.contentView.usersTableView.reloadData()
            }
            .store(
                in: &cancellables
            )
        
        viewModel.errorSender
            .receive(
                on: DispatchQueue.main
            )
            .sink { [weak self] error in
                self?.showAlert(
                    with: error
                )
            }
            .store(
                in: &cancellables
            )
    }
    
    private func setupDelegates() {
        contentView.usersTableView.dataSource = self
        contentView.usersTableView.delegate = self
    }
}

// MARK: - NAVIGATION HELPERS
extension UserListViewController {
    
    func showAlert(
        with message: String
    ) {
        let alert = UIAlertController(
            title: "Alert",
            message: message,
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(
            title: "Retry",
            style: .default
        ) { [weak self] _ in
            self?.viewModel.loadUsers()
        }
        
        alert.addAction(retryAction)
        
        present(
            alert,
            animated: true,
            completion: nil
        )
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UserTableViewCell.HEIGHT
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.storedUsers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(
            describing: UserTableViewCell.self
        )
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )
        
        guard let userCell = cell as? UserTableViewCell else {
            return cell
        }
        
        guard indexPath.row >= 0 && indexPath.row < viewModel.storedUsers.count else {
            return cell
        }
        
        let model = viewModel.storedUsers[indexPath.row]
        
        let cellModel = UserTableViewCellModel(
            iconUrlString: model.thumbnail,
            fullName: model.fullName,
            email: model.email
        )
        
        userCell.setupCell(
            with: cellModel
        )
        
        return userCell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(
            at: indexPath,
            animated: true
        )
        
        viewModel.navigateToLocation(
            of: indexPath.row
        )
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 &&
                indexPath.row == viewModel.storedUsers.count - 1 &&
                !viewModel.usersAreLoading
        else {
            return
        }
        
        viewModel.loadUsers()
    }
}
