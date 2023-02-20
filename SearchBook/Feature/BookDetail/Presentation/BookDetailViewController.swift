//
//  BookDetailViewController.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import Combine
import UIKit

final class BookDetailViewController: UIViewController, ViewModelInjectable {

    var viewModel: BookDetailViewModel?

    private let viewDidLoadSubject = PassthroughSubject<Void
    , Never>()
    private var cancellables = Set<AnyCancellable>()
    private var imageService = ImageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewDidLoadSubject.send(())
    }
}

// MARK: - Private Method

extension BookDetailViewController {
    private func bindViewModel() {
        let input = BookDetailViewModel.Input(willApperSubject: viewDidLoadSubject)
        let output = viewModel?.transform(input: input)
        output?.page
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
        }, receiveValue: { [weak self] _ in
        }).store(in: &cancellables)
    }
}
