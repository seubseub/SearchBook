//
//  BookDetailUseCaseInterface.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import Combine
import Foundation

protocol BookDetailUseCaseInterface: UseCase {
    func fetchBookDetail() -> AnyPublisher<BookDetailEntity, Error>
}
