//
//  SearchBookResponseEntity.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import Foundation

// TODO: Entity / Model 정리 필요할지 (API 응답의 모든 정보(이미지 포함)를 보여줘야함.)
struct SearchBookResponseEntityDTO: Decodable {
    let error: String?
    let total: String?
    let page: String?
    let books: [Book]?

    func dto() -> SearchBookPageModel {
        let totalBooks = Int(total ?? "0") ?? 0
        let currentPage = Int(page ?? "0") ?? 0
        return SearchBookPageModel(totalBooks: totalBooks, currentPage: currentPage, books: books ?? [])
    }
}

// MARK: - Search Book 페이지에서 total, page, books를 보여줘야한다.
struct SearchBookPageModel {
    let totalBooks: Int
    let currentPage: Int
    let books: [Book]
}

// MARK: - Book Model.
struct Book: Decodable {
    let title: String?
    let subtitle: String?
    let isbn13: String?
    let price: String?
    let image: String?
    let url: String?
}
