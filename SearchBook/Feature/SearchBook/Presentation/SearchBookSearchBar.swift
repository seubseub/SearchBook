//
//  SearchBookSearchBar.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import Combine
import UIKit

final class SearchBookSearchBar: UISearchBar {
    private(set) var textSearchResultSubject = PassthroughSubject<String, Never>()
    private(set) var cancelButtonSubject = PassthroughSubject<Void, Never>()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
    }
}

extension SearchBookSearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textSearchResultSubject.send(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelButtonSubject.send(())
    }
}
