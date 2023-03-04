//
//  UIView++.swift
//  Guidancer
//
//  Created by Vladimir Berezin on 02.11.22.
//

import UIKit

extension UIView {

    func setSize(width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }

    func putOnCenter(to view: UIView, height: CGFloat? = nil, width: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

    }

    enum Padding {
        case all(CGFloat)
        case padding(top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil)
    }

    func embed(in view: UIView, with padding: Padding? = nil) {

        var top: CGFloat {
            switch padding {
            case .all(let value):
                return value
            case .padding(let top, _, _, _):
                return top ?? 0
            case .none:
                return 0
            }
        }

        var bottom: CGFloat {
            switch padding {
            case .all(let value):
                return value
            case .padding(_, _, let bottom, _):
                return bottom ?? 0
            case .none:
                return 0
            }
        }

        var left: CGFloat {
            switch padding {
            case .all(let value):
                return value
            case .padding(_, _, _, let left):
                return left ?? 0
            case .none:
                return 0
            }
        }
        var right: CGFloat {
            switch padding {
            case .all(let value):
                return value
            case .padding(_, let right, _, _):
                return right ?? 0
            case .none:
                return 0
            }
        }

        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom),
            widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(left + right)),
            heightAnchor.constraint(equalTo: view.heightAnchor, constant: -(top + bottom))
        ])
    }

    func addCenterXAncor(inView view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }

    func addCenterYAncor(inView view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }

    func addAnchors(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddinRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddinRight).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

    }
}
