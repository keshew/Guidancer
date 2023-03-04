import UIKit

class GLabel: UILabel {
    
    init(text: String? = nil,
         font: UIFont,
         fontColor: UIColor? = .gBlack,
         numberOfLines: Int = 0,
         frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
