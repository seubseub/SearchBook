//
//  LoadingCell.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import UIKit

final class LoadingCell: UITableViewCell {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func start() {
        activityIndicator.startAnimating()
    }
}
