//
//  SearchBookUseCase.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import Combine
import Foundation

final class SearchBookUseCase: SearchBookUserCaseInterface {

    private let repository: SearchBookRepositoryInterface

    init(repository: SearchBookRepositoryInterface) {
        self.repository = repository
    }

    func searchBook(from keyword: String) -> AnyPublisher<[Book], Error> {
        return repository.fetchSearchBookList(from: keyword)
    }

    func loadNextPage()-> AnyPublisher<[Book], Error> {
        return repository.loadNextPage()
    }
}
