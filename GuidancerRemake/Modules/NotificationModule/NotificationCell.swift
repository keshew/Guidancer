//
//  NotificationCell.swift
//  GuidancerRemake
//
//  Created by Артём Коротков on 06.04.2023.
//

import UIKit

class NotificationCell: UITableViewCell {
    static var identifire = String(describing: NotificationCell.self)

    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Image")
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        return image
    }()
    
    private let informantionAboutNotificationLabel: UILabel = {
        let info = UILabel()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.numberOfLines = 0
        return info
    }()
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "imagetest2")
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstsains()
        setupView(nickname: "Artyom Korotkov", profileImage: UIImage(named: "Image")! ,postImage: UIImage(named: "imagetest2")!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(nickname: String, profileImage: UIImage, postImage: UIImage) {
        let attributedText = NSMutableAttributedString(string: nickname, attributes: [NSAttributedString.Key.font: UIFont.medium15])
        attributedText.append(NSAttributedString(string: "  have liked your post", attributes: [NSAttributedString.Key.font: UIFont.regular14]))
        informantionAboutNotificationLabel.attributedText = attributedText
        self.profileImage.image = profileImage
        self.postImage.image = postImage
    }
}

private extension NotificationCell {
    func addSubviews() {
        contentView.addSubview(profileImage)
        contentView.addSubview(informantionAboutNotificationLabel)
        contentView.addSubview(postImage)
    }
    
    func setupConstsains() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            
            informantionAboutNotificationLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            informantionAboutNotificationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postImage.leadingAnchor.constraint(equalTo: informantionAboutNotificationLabel.trailingAnchor, constant: 10),
            informantionAboutNotificationLabel.bottomAnchor.constraint(equalTo: postImage.bottomAnchor),
            
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: postImage.trailingAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 10),
            postImage.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}
