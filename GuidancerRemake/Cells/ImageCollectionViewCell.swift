import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    private let  image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            
            image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 13),
            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 13)
        ])
    }
    
    func setupImage(image: UIImage) {
        self.image.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
