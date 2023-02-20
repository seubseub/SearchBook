//
//  BookDetailUseCase.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import Combine
import Foundation

final class BookDetailUseCase: BookDetailUseCaseInterface {
    private let repository: BookDetailRepositoryInterface

    init(repository: BookDetailRepositoryInterface) {
        self.repository = repository
    }
    func fetchBookDetail() -> AnyPublisher<BookDetailEntity, Error> {
        return repository.fetchBookDetail()
    }
}
