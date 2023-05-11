//
//  GTextField.swift
//  Guidancer
//
//  Created by Ибрагим Сахратулаев on 25.11.2022.
//

import UIKit

class GTextField: UIView {
    
    let image: UIImage?
    let systemImage: UIImage?
    let font: UIFont
    let placeholder: String
    let imageView = UIImageView()
    let textField = UITextField()
    
    init(imageName: String,
         placeholder: String,
         font: UIFont,
         frame: CGRect = .zero
    ) {
        self.image = UIImage(named: imageName)
        self.systemImage = UIImage(systemName: imageName)
        self.font = font
        self.placeholder = placeholder
        self.imageView.image = image
        
        super.init(frame: frame)
    }
    
    init(systemImageName: String,
         placeholder: String,
         font: UIFont,
         frame: CGRect = .zero
    ) {
        self.systemImage = UIImage(systemName: systemImageName)
        self.font = font
        self.placeholder = placeholder
        self.imageView.image = systemImage
        self.image = UIImage(named: "systemImage")
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        layer.cornerRadius = 16
        layer.borderWidth = 1
        
        self.addSubview(imageView)
        imageView.tintColor = .black
        imageView.addAnchors(left: self.leftAnchor,
                             bottom: self.bottomAnchor,
                             paddingLeft: 8,
                             paddingBottom: 13)
        imageView.setSize(width: 24, height: 24)
        
        self.addSubview(textField)
        textField.addAnchors(left: imageView.rightAnchor,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor,
                             paddingLeft: 8,
                             paddingBottom: 13)
        textField.placeholder = placeholder
        textField.textColor = .black
        textField.font = font
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
}
