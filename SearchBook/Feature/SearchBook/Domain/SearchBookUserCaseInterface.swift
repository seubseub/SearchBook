//
//  SearchBookUserCaseInterface.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import Combine
import Foundation

protocol SearchBookUserCaseInterface: UseCase {
    func searchBook(from keyword: String) -> AnyPublisher<[Book], Error>
    func loadNextPage()-> AnyPublisher<[Book], Error>
}
