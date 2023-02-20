//
//  SearchBookCoordinator.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import UIKit

class SearchBookCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?

    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
    }

    func start() {
        let searchBookStoryboard = UIStoryboard(name: "SearchBook", bundle: nil)
        let dataSource = SearchBookAPIDataSource()
        let repositoy = SearchBookRepository(dataSource: dataSource)
        let useCase = SearchBookUseCase(repository: repositoy)
        let viewModel = SearchBookViewModel(useCase: useCase)
        let viewController = searchBookStoryboard.instantiateViewController(type: SearchBookViewController.self, viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }

    func showBookDetail(id: String) {
        let bookDetailCoordinator = BookDetailCoordinator(navigationController: navigationController)
        bookDetailCoordinator.parentCoordinator = parentCoordinator
        bookDetailCoordinator.id = id
        childCoordinators.append(bookDetailCoordinator)
        bookDetailCoordinator.start()
    }
}
