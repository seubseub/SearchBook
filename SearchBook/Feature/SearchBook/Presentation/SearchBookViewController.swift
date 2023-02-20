//
//  SearchBookViewController.swift
//  SearchBook
//
//  Created by brian on 2023/02/17.
//

import Combine
import UIKit

final class SearchBookViewController: UIViewController, ViewModelInjectable {

    @IBOutlet private weak var searchBar: SearchBookSearchBar!
    @IBOutlet private weak var tableView: UITableView!

    private let tapSearchButtonSubject = PassthroughSubject<String, Never>()
    private let tapClearButtonSubject = PassthroughSubject<Void, Never>()
    private let tapItemSubject = PassthroughSubject<String, Never>()
    private let nextPageSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    var viewModel: SearchBookViewModel?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        searchBar.textSearchResultSubject
            .throttle(for: 0.3, scheduler: RunLoop.main, latest: false)
            .sink { [weak self] keyword in
                self?.tapSearchButtonSubject.send(keyword)
            }.store(in: &cancellables)

        searchBar.cancelButtonSubject
            .throttle(for: 0.3, scheduler: RunLoop.main, latest: false)
            .sink { [weak self] _ in
                self?.tapClearButtonSubject.send(())
            }.store(in: &cancellables)
    }
}

// MARK: - Private Method

extension SearchBookViewController {
    private func setupViews() {
        let cellIdentifier = SearchBookCell.reuseIdentifier
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        let loadingCellIdentifier = LoadingCell.reuseIdentifier
        tableView.register(UINib(nibName: loadingCellIdentifier, bundle: nil), forCellReuseIdentifier: loadingCellIdentifier)
    }

    private func bindViewModel() {
        let input = SearchBookViewModel.Input(didTapSearchButton: tapSearchButtonSubject,
                                              didTapClearButton: tapClearButtonSubject,
                                              nextPageSubject: nextPageSubject)
        let output = viewModel?.transform(input: input)
        output?.page
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in            
        }, receiveValue: { [weak self] _ in
            UIView.setAnimationsEnabled(false)
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections(IndexSet(0...1), with: .none)
            self?.tableView.endUpdates()
        }).store(in: &cancellables)
    }
}

// MARK: - UITableViewDelegate

extension SearchBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel?.books[safe: indexPath.row]?.isbn13,
        let navigationController = self.navigationController else {
            return
        }
        let coord = SearchBookCoordinator(navigationController: navigationController)
        coord.showBookDetail(id: id)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        let isPaging = self.viewModel?.isPaging ?? false
        // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
        if offsetY > (contentHeight - height) {
            if isPaging == false {
                nextPageSubject.send(())
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchBookViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isPaging = self.viewModel?.isPaging ?? false
        if section == 0 {
            return self.viewModel?.books.count ?? 0
        } else if section == 1 && isPaging {
            return 1
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBookCell.reuseIdentifier) as? SearchBookCell,
                  let book = self.viewModel?.books[safe: indexPath.row] else {
                return UITableViewCell()
            }
            let cellViewModel = SearchBookCellViewModel(book: book)
            cell.update(with: cellViewModel)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell else {
                return UITableViewCell()
            }

            cell.start()

            return cell
        }
    }


}
