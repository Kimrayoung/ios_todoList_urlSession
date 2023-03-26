//
//  Protocol+Ext.swift
//  TodoUrlSession
//
//  Created by 김라영 on 2023/03/21.
//

import Foundation
import UIKit

//Nib파일 가져오기
protocol Nibbed {
    static var uiNib: UINib { get }
}

extension Nibbed {
    static var uiNib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: nil)
    }
}

extension UITableViewCell: Nibbed {}

//Nib파일 이름 가져오기
protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifier {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifier {}
