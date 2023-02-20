//
//  BookDetailCoordinator.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import UIKit

final class BookDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var id: String = ""
    weak var parentCoordinator: MainCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let bookDetailStoryboard = UIStoryboard(name: "BookDetail", bundle: nil)
        let dataSource = BookDetailAPIDataSource()
        let repositoy = BookDetailRepository(dataSource: dataSource, id: id)
        let useCase = BookDetailUseCase(repository: repositoy)
        let viewModel = BookDetailViewModel(useCase: useCase)
        let viewController = bookDetailStoryboard.instantiateViewController(type: BookDetailViewController.self, viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
