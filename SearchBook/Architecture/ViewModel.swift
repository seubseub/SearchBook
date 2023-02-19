//
//  ViewModel.swift
//  SearchBook
//
//  Created by brian on 2023/02/17.
//

import Foundation

// MARK: - ViewModel

protocol ViewModel {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
