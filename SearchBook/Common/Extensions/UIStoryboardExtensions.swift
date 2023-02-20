//
//  UIStoryboardExtensions.swift
//  SearchBook
//
//  Created by brian on 2023/02/17.
//

import UIKit

extension UIStoryboard {
    func instantiateViewController<T: UIViewController & ViewModelInjectable>(type: T.Type, viewModel: T.VM) -> T {
        guard let viewController = instantiateViewController(withIdentifier: type.reuseIdentifier) as? T else {
            assertionFailure()
            return T()
        }
        viewController.inject(viewModel: viewModel)
        return viewController
    }
}
