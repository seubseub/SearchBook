//
//  SearchBookAPIDataSource.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import Combine
import Foundation

enum SearchBookAPIError: Error {
    case serverError
}

final class SearchBookAPIDataSource: SearchBookDataSourceInterface {
    private let urlString = "https://api.itbook.store/1.0/search/"
    private var cancellables = Set<AnyCancellable>()
    
    func fetchSearchBookList(from keyword: String, page: Int) -> AnyPublisher<SearchBookPageModel?, Error> {
        guard let url = URL(string: urlString + "\(keyword)/\(page)") else {
            return Just(nil)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
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
            .decode(type: SearchBookResponseEntityDTO.self, decoder: JSONDecoder())
            .tryMap { item in
                return item.dto()
            }
            .eraseToAnyPublisher()
    }
    
}
