//
//  GWhiteRectangleButton.swift
//  Guidancer
//
//

import UIKit

class GWhiteRectangleButton: GButton {
    
    init(title: String,
         frame: CGRect = .zero,
         
         didTap: ((UIButton) -> Void)? = nil
    ) {
        self.title = title
        super.init(frame: frame, didTap: didTap)
    }
    
    let title: String
    let color: UIColor = .white
    
    override func configureUI() {
        super.configureUI()
//        setSize(width: 328, height: 49)
        backgroundColor = color
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.font = .medium18
        setTitle(title, for: .normal)
        layer.cornerRadius = 16
        layer.borderColor = UIColor.gBlack?.cgColor
        layer.borderWidth = 1.0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
