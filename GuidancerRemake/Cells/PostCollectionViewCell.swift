import UIKit
import Kingfisher

class PostCollectionViewCell: GCollectionViewCell {
    
    private let informationInPost = DescriptionPostSV()
    let contentStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        cornerAndShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentStackView.addArrangedSubview(informationInPost)
        contentStackView.axis = .vertical
        contentStackView.embed(in: contentView)
    }
    
    private func cornerAndShadow() {
        self.layer.cornerRadius = 25
        self.backgroundColor = .white
        self.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.gBlack?.cgColor
    }
    
    func setupContent(post: GPost, image: String, cityName: String, descriptionOfPlace: String, numberOfLikes: Int) {
        informationInPost.setupContent(image: image,
                                       bestPlaceOfCityName: cityName,
                                       descriptionOfPlace: descriptionOfPlace)
    }
    
    private final class DescriptionPostSV: UIStackView {

        var imageView: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.layer.cornerRadius = 25.0
            image.translatesAutoresizingMaskIntoConstraints = false
            image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            return image
        }()
        
        let bestPlaceOfCityName = GLabel(font: .regular12)
        
        let descriptionOfPlace = GLabel(font: .regular10)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setup() {
            spacing = 3
            distribution = .equalCentering
            axis = .vertical
            alignment = .firstBaseline
            addArrangedSubview(imageView)
            addArrangedSubview(bestPlaceOfCityName)
            addArrangedSubview(descriptionOfPlace)
            bestPlaceOfCityName.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
            
            NSLayoutConstraint.activate([
                imageView.bottomAnchor.constraint(equalTo: bestPlaceOfCityName.topAnchor, constant: -10),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 80),
                
                bestPlaceOfCityName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
    
                descriptionOfPlace.topAnchor.constraint(equalTo: bestPlaceOfCityName.bottomAnchor, constant: 5),
                descriptionOfPlace.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                trailingAnchor.constraint(equalTo: descriptionOfPlace.trailingAnchor, constant: 10),
            ])
        }
        
        func setupContent(image: String?,
                          bestPlaceOfCityName: String,
                          descriptionOfPlace: String
        ) {
            guard let image = image else { return }
            self.imageView.kf.indicatorType = .activity
            self.imageView.kf.setImage(with: URL(string: image))
            self.bestPlaceOfCityName.text = bestPlaceOfCityName
            self.descriptionOfPlace.text = descriptionOfPlace
        }
    }
    
}
