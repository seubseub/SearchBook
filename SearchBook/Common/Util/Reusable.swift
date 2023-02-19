//
//  Reusable.swift
//  SearchBook
//
//  Created by brian on 2023/02/17.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: Reusable { }
