//
//  SearchBookViewModel.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import Combine
import Foundation

struct SearchButtonInput {
    let keyword: String
    let page: Int
}

// TODO: Class -> Struct으로 변경이 필요한지 고민.

final class SearchBookViewModel: ViewModel {
    struct Input {
        let didTapSearchButton: PassthroughSubject<String, Never>
        let didTapClearButton: PassthroughSubject<Void, Never>
        let nextPageSubject: PassthroughSubject<Void, Never>
    }

    struct Output {
        let page: PassthroughSubject<(), Error>
    }

    private let useCase: SearchBookUserCaseInterface

    private var cancellables = Set<AnyCancellable>()

    var isPaging: Bool = false // 현재 페이징 중인지 체크하는 flag

    private(set) var books: [Book] = []

    init(useCase: SearchBookUserCaseInterface) {
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {
        let pageOutput = PassthroughSubject<(), Error>()
        input.didTapSearchButton.sink { completion in
            print("eee")
        } receiveValue: { [weak self] input in
            guard let self = self else { return }
            self.isPaging = true
            self.useCase.searchBook(from: input).sink(receiveCompletion: { [weak self] completion in
                self?.isPaging = false
            }, receiveValue: { [weak self] bookList in
                self?.books = bookList
                pageOutput.send(())
            }).store(in: &self.cancellables)
        }.store(in: &cancellables)

        input.nextPageSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.isPaging = true
            self.useCase.loadNextPage().sink { [weak self]_ in
                self?.isPaging = false
            } receiveValue: { [weak self] bookList in
                guard self?.books.count != bookList.count else { return }
                self?.books = bookList
                self?.isPaging = false
                pageOutput.send(())
            }.store(in: &self.cancellables)
        }.store(in: &cancellables)
        
        return Output(page: pageOutput)
    }
}
