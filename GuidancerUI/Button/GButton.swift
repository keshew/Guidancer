import UIKit

class GButton: UIButton {
    
    
    init(frame: CGRect = .zero,
         didTap: ((UIButton) -> Void)? = nil
    ) {
     
        self.didTap = didTap
        super.init(frame: frame)
        configureUI()
    }
    
    let didTap: ((UIButton) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        if didTap != nil {
            addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    @objc private func buttonTapped() {
        guard let didTap = didTap else { return }
        didTap(self)
    }
    
}
