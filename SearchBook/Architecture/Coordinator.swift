//
//  Coordinator.swift
//  SearchBook
//
//  Created by brian on 2023/02/17.
//

import UIKit

// MARK: - Coordinator

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
