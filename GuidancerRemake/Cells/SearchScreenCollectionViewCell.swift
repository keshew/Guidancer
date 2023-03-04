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

    override func setupContent(post: GPost, image: String, cityName: String, descriptionOfPlace: String) {
        super.setupContent(post: post, image: image, cityName: cityName, descriptionOfPlace: descriptionOfPlace)
        informationInPost.setupContent(likes: post.likes, comments: post.comments)
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
            heartImage.tintColor = .black
            stack.embed(in: self, with: .padding(top: 0, right: 10, bottom: 10, left: 330))
        }

        func setupContent(likes: Int,
                          comments: Int) {
            likesNumber.text = String("\(likes)K")
        }
    }

}

