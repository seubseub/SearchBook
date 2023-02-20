//
//  SearchBookDataSourceInterface.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import Combine
import Foundation

protocol SearchBookDataSourceInterface {
    func fetchSearchBookList(from keyword: String, page: Int) -> AnyPublisher<SearchBookPageModel?, Error>
}
