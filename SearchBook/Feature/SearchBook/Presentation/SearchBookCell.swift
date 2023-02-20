//
//  SearchBookCell.swift
//  SearchBook
//
//  Created by brian on 2023/02/19.
//

import UIKit

struct SearchBookCellViewModel: ViewModel {
    typealias Input = Void
    typealias Output = Void

    let book: Book

    func transform(input: Void) -> Void {}
}

final class SearchBookCell: UITableViewCell, ViewModelUpdatable {
    @IBOutlet private weak var bookTitleLabel: UILabel!
    @IBOutlet private weak var bookSubTitleLabel: UILabel!
    @IBOutlet private weak var bookCoverImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    private var imageService = ImageService()

    private var imageRequest: Cancellable?

    override func awakeFromNib() {
        super.awakeFromNib()
        bookCoverImageView.contentMode = .scaleAspectFill
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bookTitleLabel.text = nil
        bookSubTitleLabel.text = nil
        bookCoverImageView.image = nil
        activityIndicator.stopAnimating()
        imageRequest?.cancel()
    }

    func update(with viewModel: SearchBookCellViewModel) {
        bookTitleLabel.text = viewModel.book.title
        bookSubTitleLabel.text = viewModel.book.subtitle
        guard let url = URL(string: viewModel.book.image ?? "") else { return }
        activityIndicator.startAnimating()
        imageRequest = imageService.image(for: url) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            self?.bookCoverImageView.image = image
        }
    }
}
