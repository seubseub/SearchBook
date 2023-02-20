//
//  BookDetailRepository.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import Combine
import Foundation

final class BookDetailRepository: BookDetailRepositoryInterface {
    private let dataSource: BookDetailDataSourceInterface

    private let id: String

    init(dataSource: BookDetailDataSourceInterface, id: String) {
        self.dataSource = dataSource
        self.id = id
    }
    func fetchBookDetail() -> AnyPublisher<BookDetailEntity, Error> {
        return dataSource.fetchBookDetail(from: id)
    }
}
