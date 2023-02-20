//
//  ArrayExtensions.swift
//  SearchBook
//
//  Created by brian on 2023/02/20.
//

import UIKit

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
