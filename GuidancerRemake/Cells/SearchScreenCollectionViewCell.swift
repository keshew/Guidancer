//
//  SearchScreenCollectionViewCell.swift
//  Guidancer
//
//  Created by Артём Коротков on 24.11.2022.
//

import UIKit

class SearchScreenCollectionViewCell: PostCollectionViewCell {

    private let informationInPost = ChangableInfoOfPostSV()

    override func setup() {
        super.setup()
        contentStackView.addArrangedSubview(informationInPost)
    }

    override func setupContent(post: GPost, image: String, cityName: String, descriptionOfPlace: String, numberOfLikes: Int) {
        super.setupContent(post: post, image: image, cityName: cityName, descriptionOfPlace: descriptionOfPlace, numberOfLikes: numberOfLikes)
        informationInPost.setupContent(likes: numberOfLikes, comments: post.comments)
    }

    private final class ChangableInfoOfPostSV: UIView {


        let likesNumber = GLabel(font: .regular11)
        let heartImage: GLikeCommentButton = {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 0, weight: .light, scale: .small)
            let largeBoldDoc = UIImage(systemName: "heart", withConfiguration: largeConfig)
            let image = GLikeCommentButton(icon: largeBoldDoc)
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setup() {
            let stack = UIStackView(arrangedSubviews: [likesNumber, heartImage])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.spacing = 3
            heartImage.tintColor = .black
            addSubview(stack)
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: topAnchor),
                trailingAnchor.constraint(equalTo: stack.trailingAnchor,constant: 20),
                bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: 5)
            ])
        }

        func setupContent(likes: Int,
                          comments: Int) {
            likesNumber.text = String("\(likes)")
        }
    }
}
