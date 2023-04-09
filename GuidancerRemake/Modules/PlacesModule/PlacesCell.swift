import UIKit

class PlacesCell: UITableViewCell {
    static var identifire = String(describing: PlacesCell.self)

    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Image")
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        return image
    }()
    
    private let nameOfPlaceLabel: UILabel = {
        let info = UILabel()
        info.font = .medium18
        return info
    }()
    
    private let descriptionOfPlaceLabel: UILabel = {
        let info = UILabel()
        info.font = .regular15
        return info
    }()
    
    private lazy var informantionAboutPlaceLabel: UIStackView = {
        let info = UIStackView(arrangedSubviews: [nameOfPlaceLabel,descriptionOfPlaceLabel])
        info.spacing = 5
        info.translatesAutoresizingMaskIntoConstraints = false
        info.axis = .vertical
        return info
    }()
    
    private lazy var barButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstsains()
        setupView(nameOfPlace: "Aleksnadrovsk",
                  profileImage: UIImage(named: "imagetest2")!,
                  descriptionOfPlace: "AleksnadrovskAleksnadrovskAleksnadrovskAleksnadrovsk",
                  numberOfLikes: " 100")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(nameOfPlace: String, profileImage: UIImage, descriptionOfPlace: String, numberOfLikes: String) {
        nameOfPlaceLabel.text = nameOfPlace
        descriptionOfPlaceLabel.text = descriptionOfPlace
        profileImageView.image = profileImage
        barButton.setTitle(numberOfLikes, for: .normal)
    }
}

private extension PlacesCell {
    func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(informantionAboutPlaceLabel)
        contentView.addSubview(barButton)
    }
    
    func setupConstsains() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),

            informantionAboutPlaceLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            informantionAboutPlaceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            barButton.leadingAnchor.constraint(equalTo: informantionAboutPlaceLabel.trailingAnchor, constant: 10),

            barButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: barButton.trailingAnchor, constant: 20),
            contentView.bottomAnchor.constraint(equalTo: barButton.bottomAnchor, constant: 10),
        ])
    }
}
