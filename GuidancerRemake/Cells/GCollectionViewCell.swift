//
//  GCollectionViewCell.swift
//  Guidancer
//
//  Created by Vladimir Berezin on 26.11.22.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class GCollectionViewCell: UICollectionViewCell, ReusableView {

    static var identifier: String {
        String(describing: self)
    }

}
