//
//  BookDetailViewModel.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import Combine
import Foundation

final class BookDetailViewModel: ViewModel {
    struct Input {
        let willApperSubject: PassthroughSubject<Void, Never>
    }

    struct Output {
        let page: PassthroughSubject<(), Error>
    }

    private let useCase: BookDetailUseCaseInterface

    private var cancellables = Set<AnyCancellable>()

    init(useCase: BookDetailUseCaseInterface) {
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {
        let pageOutput = PassthroughSubject<(), Error>()
        input.willApperSubject.sink { completion in
        } receiveValue: { [weak self] id in
            guard let self = self else { return }
            self.useCase.fetchBookDetail().sink(receiveCompletion: { completion in
            }, receiveValue: { bookDetail in
                pageOutput.send(())
            }).store(in: &self.cancellables)
        }.store(in: &cancellables)

        return Output(page: pageOutput)
    }
}
