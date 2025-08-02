//
//  UserListIntegrationTests.swift
//  RandomUsers
//
//  Created by Илья Салей on 2.08.25.
//

import XCTest
@testable import RandomUsers

final class UserListIntegrationTests: XCTestCase {
    
    func test_init_doesnotCallProvider() throws {
        let mock = UserProviderMock()
        let _ = makeSUT(provider: mock)
        
        XCTAssertEqual(mock.listOfUsersRequestsCount, 0)
    }
    
    func test_viewDidLoad_callsProvider() throws {
        let mock = UserProviderMock()
        let sut = makeSUT(provider: mock)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(mock.listOfUsersRequestsCount, 1)
    }
    
    func test_sut_callsAlertOnFailedRequest() throws {
        let spy = UserProviderSpy()
        let alertPresenter = AlertPresenterMock()
        let sut = makeSUT(provider: spy, alertPresenter: alertPresenter)
        
        sut.loadViewIfNeeded()
        spy.completeListOfUsersWithFailure()
        
        XCTAssertEqual(alertPresenter.presentAlertRequestsCount, 1)
    }
    
    func test_sut_callsProviderOnRetryPressed() throws {
        let mock = UserProviderMock()
        let spy = UserProviderSpy(decoratee: mock)
        let alertPresenter = AlertPresenterSpy()
        let sut = makeSUT(provider: spy, alertPresenter: alertPresenter)
        
        sut.loadViewIfNeeded()
        spy.completeListOfUsersWithFailure()
        alertPresenter.simulateActionButtonTap()
        
        XCTAssertEqual(mock.listOfUsersRequestsCount, 2)
    }
    
    func test_sut_displaysCellsOnSuccessfulRequest() throws {
        let spy = UserProviderSpy()
        let sut = makeSUT(provider: spy)
        let tableView = getUsersTableView(from: sut)
        
        sut.loadViewIfNeeded()
        spy.completeListOfUsersSuccessfully()
        
        let numberOfRows = tableView?.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, spy.userRequestCount)
    }
    
    func test_sut_doesnotCallProviderOnLastCellNotDisplayed() throws {
        let mock = UserProviderMock()
        let spy = UserProviderSpy(decoratee: mock)
        let sut = makeSUT(provider: spy)
        let tableView = getUsersTableView(from: sut)
        
        sut.loadViewIfNeeded()
        spy.completeListOfUsersSuccessfully()
        performTableViewScrollingToBottom(
            sut: sut,
            tableView: tableView,
            numberOfRows: spy.userRequestCount - 1
        )
        
        XCTAssertEqual(mock.listOfUsersRequestsCount, 1)
    }
    
    func test_sut_callsProviderOnLastCellDisplayed() throws {
        let mock = UserProviderMock()
        let spy = UserProviderSpy(decoratee: mock)
        let sut = makeSUT(provider: spy)
        let tableView = getUsersTableView(from: sut)
        
        sut.loadViewIfNeeded()
        spy.completeListOfUsersSuccessfully()
        performTableViewScrollingToBottom(
            sut: sut,
            tableView: tableView,
            numberOfRows: spy.userRequestCount
        )
        
        XCTAssertEqual(mock.listOfUsersRequestsCount, 2)
    }
    
    func test_sut_displaysMapViewOnCellSelection() throws {
        let spy = UserProviderSpy()
        let sut = makeSUT(provider: spy)
        let tableView = getUsersTableView(from: sut)
        
        sut.loadViewIfNeeded()
        spy.completeListOfUsersSuccessfully()
        simulateCellTap(
            sut: sut,
            tableView: tableView
        )
        
        let mapView = getMapView(from: sut)
        XCTAssertNotNil(mapView)
    }
}

// MARK: - HELPERS
extension UserListIntegrationTests {
    
    private func simulateCellTap(
        sut: UserListViewController,
        tableView: UITableView?
    ) {
        let indexPath = IndexPath(
            row: 0,
            section: 0
        )
        
        if let tableView {
            sut.tableView(
                tableView,
                didSelectRowAt: indexPath
            )
        }
    }
    
    private func performTableViewScrollingToBottom(
        sut: UserListViewController,
        tableView: UITableView?,
        numberOfRows: Int
    ) {
        let indexPath = IndexPath(
            row: numberOfRows - 1,
            section: 0
        )
        
        tableView?.scrollToRow(
            at: indexPath,
            at: .middle,
            animated: false
        )
        
        if let tableView, let cell = sut.tableView(tableView, cellForRowAt: indexPath) as? UserTableViewCell {
           sut.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        }
    }
    
    private func getMapView(
        from sut: UIViewController
    ) -> Any? {
        let mirror = Mirror(
            reflecting: sut
        )
        
        return mirror.descendant("contentView", 0)
    }
    
    private func getUsersTableView(
        from sut: UIViewController
    ) -> UITableView? {
        let mirror = Mirror(
            reflecting: sut
        )
        
        if let usersTableView = mirror.descendant("contentView", "usersTableView") as? UITableView {
            return usersTableView
        }
        
        return nil
    }

    private func makeSUT(
        provider: UserProviderProtocol,
        alertPresenter: AlertPresenterProtocol = AlertPresenter(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> UserListViewController {
        let viewModel = UserListViewModel(
            provider: provider,
            alertPresenter: alertPresenter
        )
        
        let controller = UserListViewController(
            viewModel: viewModel
        )
        
        trackForMemoryLeaks(viewModel, file: file, line: line)
        trackForMemoryLeaks(controller, file: file, line: line)
        
        return controller
    }
}
