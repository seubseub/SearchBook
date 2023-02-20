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

    // TODO: DI
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // Main VC를 통해 진행.
    func start() {
        // usecase / repository 등 주입.
        let searchBookStoryboard = UIStoryboard(name: "SearchBook", bundle: nil)
        let dataSource = SearchBookAPIDataSource()
        let repositoy = SearchBookRepository(dataSource: dataSource)
        let useCase = SearchBookUseCase(repository: repositoy)
        let viewModel = SearchBookViewModel(useCase: useCase)
        let viewController = searchBookStoryboard.instantiateViewController(type: SearchBookViewController.self, viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
