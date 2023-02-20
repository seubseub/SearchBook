//
//  MainCoordinator.swift
//  SearchBook
//
//  Created by brian on 2023/02/17.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // Main VC를 통해 진행.
    func start() {
        showSearchBook()
    }

    private func showSearchBook() {
        let searchBookCoordinator = SearchBookCoordinator(navigationController: navigationController)
        searchBookCoordinator.parentCoordinator = self
        childCoordinators.append(searchBookCoordinator)
        searchBookCoordinator.start()
    }
}
