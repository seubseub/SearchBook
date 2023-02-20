//
//  BookDetailRepositoryInterface.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import Combine
import Foundation

protocol BookDetailRepositoryInterface: Repository {
    func fetchBookDetail() -> AnyPublisher<BookDetailEntity, Error>
}
