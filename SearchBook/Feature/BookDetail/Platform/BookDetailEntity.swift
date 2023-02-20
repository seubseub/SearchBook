//
//  BookDetailResponseEntity.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import Foundation

// MARK: - BookDetail Entity.
struct BookDetailEntity: Decodable {
    let error: String?
    let title: String?
    let subtitle: String?
    let authors: String?
    let publisher: String?
    let language: String?
    let isbn10: String?
    let isbn13: String?
    let pages: String?
    let year: String?
    let rating: String?
    let desc: String?
    let price: String?
    let image: String?
    let url: String?
}
