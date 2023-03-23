//
//  GRectangleButton.swift
//  Guidancer
//
//  Created by Vladimir Berezin on 01.11.22.
//

import UIKit

class GRectangleButton: GButton {
    
    init(title: String,
         image: UIImage? = nil,
         frame: CGRect = .zero,
         
         didTap: ((UIButton) -> Void)? = nil
    ) {
        self.title = title
        self.image = image
        super.init(frame: frame, didTap: didTap)
    }
    
    let image: UIImage?
    let title: String
    let color: UIColor? = .black
    
    override func configureUI() {
        super.configureUI()
        backgroundColor = color
        titleLabel?.font = .medium21
        setTitle(title, for: .normal)
        layer.cornerRadius = 16
        if image != nil {
            setImage(image, for: .normal)
            clipsToBounds = true
            var configuration = UIButton.Configuration.filled()
            configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.medium21
                return outgoing
               }
            configuration.imagePadding = 10
            configuration.baseBackgroundColor = color
            self.configuration = configuration
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
