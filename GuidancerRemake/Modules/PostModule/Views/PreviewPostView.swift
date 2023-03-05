import UIKit
import Kingfisher

class PreviewPostView: UIView {

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DarkGray")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var imageOfProfile: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()

    private let titleLabel: GLabel = {
        let label = GLabel(font: .medium18)
        
        return label
    }()

    private let secondTitleLabel: GLabel = {
        let label = GLabel(font: .medium14)

        return label
    }()

    var currentMinute: GLabel = {
        let label = GLabel(font: .medium11)
        label.textColor = UIColor(named: "DarkGray")
        label.textAlignment = .left
        return label
    }()

    let maxMinute: GLabel = {
        let label = GLabel(font: .medium11)
        label.textColor = UIColor(named: "DarkGray")
        label.textAlignment = .right
        return label
    }()

    private let nicknameLabel: GLabel = {
        let label = GLabel(font: .semiBold14)

        return label
    }()

    private let textLabel: GLabel = {
        let label = GLabel(font: .regular15)
        return label
    }()

    var progressView: UISlider = {
        let view = UISlider()
        view.tintColor = UIColor(named: "green")
        return view
    }()

    let pauseButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "pause"), for: .normal)
        return btn
    }()

    lazy var leftButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "left"), for: .normal)
        return btn
    }()

    private let rightButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "right"), for: .normal)
        return btn
    }()

    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftButton, pauseButton, rightButton])
        view.axis = .horizontal
        view.spacing = 1
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var timeStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [currentMinute, maxMinute])
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageOfProfile, titleLabel, secondTitleLabel, nicknameLabel, textLabel, progressView])
        view.axis = .vertical
        view.spacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(image: String?, nickname: String, firstTitle: String, secondTitle: String, text: String) {
        imageOfProfile.kf.setImage(with: URL(string: image ?? ""))
        nicknameLabel.text = nickname
        titleLabel.text = firstTitle
        secondTitleLabel.text = secondTitle
        textLabel.text = text
    }

}

private extension PreviewPostView {
    func configureView() {
        backgroundColor = .white

        secondTitleLabel.textColor = UIColor(named: "DarkGray")
        addSubview(mainStackView)
        addSubview(buttonStackView)
        addSubview(timeStackView)
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 10),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),

            lineView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIScreen.main.bounds.width / 2 - UIScreen.main.bounds.width / 4),

            mainStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 25),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 25),

            timeStackView.heightAnchor.constraint(equalToConstant: 10),
            timeStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10),
            timeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: timeStackView.trailingAnchor, constant: 25),

            buttonStackView.heightAnchor.constraint(equalToConstant: 58),
            buttonStackView.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor, constant: 80),
            bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 25),
            
            imageOfProfile.heightAnchor.constraint(equalToConstant: 370),
//            titleLabel.heightAnchor.constraint(equalToConstant: 20)
            //work on this
        ])
    }
}
