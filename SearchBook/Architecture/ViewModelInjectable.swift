//
//  ViewModelInjectable.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import UIKit

protocol ViewModelInjectable: AnyObject {
    associatedtype VM: ViewModel

    var viewModel: VM? { get set }

    func inject(viewModel: VM)
}

protocol ViewModelUpdatable: AnyObject {
    associatedtype VM: ViewModel

    func update(with viewModel: VM)
}

extension ViewModelInjectable {
    func inject(viewModel: VM) {
        self.viewModel = viewModel
    }
}
