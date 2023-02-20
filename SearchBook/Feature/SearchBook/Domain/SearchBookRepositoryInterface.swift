//
//  SearchBookRepositoryInterface.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import Combine
import Foundation

protocol SearchBookRepositoryInterface: Repository {
    func fetchSearchBookList(from keyword: String) -> AnyPublisher<[Book], Error>
    func loadNextPage()-> AnyPublisher<[Book], Error>
}
