//
//  GWhiteRectangleButton.swift
//  Guidancer
//
//

import UIKit

class GWhiteRectangleButton: GButton {
    
    init(title: String,
         frame: CGRect = .zero,
         backColor: UIColor = .white,
         tintColor: UIColor = .black,
         didTap: ((UIButton) -> Void)? = nil
    ) {
        self.tintColors = tintColor
        self.title = title
        super.init(frame: frame, didTap: didTap)
        self.backgroundColor = backColor
    }
    
    let title: String
    let tintColors: UIColor
    
    override func configureUI() {
        super.configureUI()
        setSize(height: 44)
        titleLabel?.font = .regular15
        setTitle(title, for: .normal)
        layer.cornerRadius = 15
        layer.borderWidth = 0.8
        setTitleColor(tintColors, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
