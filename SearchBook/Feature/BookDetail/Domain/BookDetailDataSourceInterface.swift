//
//  BookDetailDataSourceInterface.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import Combine
import Foundation

protocol BookDetailDataSourceInterface {
    func fetchBookDetail(from id: String) -> AnyPublisher<BookDetailEntity, Error>
}
