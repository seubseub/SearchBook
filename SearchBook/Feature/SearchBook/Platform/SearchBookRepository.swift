//
//  SearchBookRepository.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import Combine
import Foundation

final class SearchBookRepository: SearchBookRepositoryInterface {
    private let dataSource: SearchBookDataSourceInterface

    private var totalPage = 0
    private var pageNum = 1
    private var keyword = ""
    private var hasNextPage = false
    private var books: [Book] = []

    init(dataSource: SearchBookDataSourceInterface) {
        self.dataSource = dataSource
    }

    func fetchSearchBookList(from keyword: String) -> AnyPublisher<[Book], Error> {
        self.keyword = keyword
        self.pageNum = 1
        return dataSource.fetchSearchBookList(from: keyword, page: pageNum)
            .tryMap { [weak self] bookModel in
                let hasNextPage = bookModel?.totalBooks != 0
                self?.hasNextPage = hasNextPage
                return bookModel?.books ?? []
            }
            .eraseToAnyPublisher()
    }

    func loadNextPage()-> AnyPublisher<[Book], Error> {
        guard self.hasNextPage else {
            return Just(self.books)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        self.pageNum += 1
        return dataSource.fetchSearchBookList(from: keyword, page: pageNum)
            .tryMap { [weak self] bookModel in
                guard let self = self else { return [] }
                let nextBooks = bookModel?.books ?? []
                let hasNextPage = bookModel?.totalBooks != 0
                self.hasNextPage = hasNextPage
                guard hasNextPage else {
                    return self.books
                }

                self.books.append(contentsOf: nextBooks)
                return self.books
            }
            .eraseToAnyPublisher()
    }
}
