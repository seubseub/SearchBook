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
        let SearchBookStoryboard = UIStoryboard(name: "SearchBook", bundle: nil)
        let searchBookViewController = SearchBookStoryboard.instantiateViewController(withIdentifier: SearchBookViewController.reuseIdentifier)
//         let vc = View
        navigationController.pushViewController(searchBookViewController, animated: false)
    }
}
