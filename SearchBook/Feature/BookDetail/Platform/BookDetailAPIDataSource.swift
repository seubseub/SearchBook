//
//  BookDetailAPIDataSource.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import Combine
import Foundation

final class BookDetailAPIDataSource: BookDetailDataSourceInterface {
    private let urlString = "https://api.itbook.store/1.0/books/"
    private var cancellables = Set<AnyCancellable>()

    func fetchBookDetail(from id: String) -> AnyPublisher<BookDetailEntity, Error> {
        let url = URL(string: urlString + id)

        return URLSession.shared.dataTaskPublisher(for: url!)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw SearchBookAPIError.serverError
                }
                switch httpResponse.statusCode {
                case 200:
                    return data
                default:
                    throw SearchBookAPIError.serverError
                }
            }
            .decode(type: BookDetailEntity.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
