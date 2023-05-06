import UIKit
import MobileCoreServices
import AVFoundation


protocol CreatePostViewProtocol: AnyObject {
    var guideNameTextField: UITextField { get set }
    var guideDescriptionTextField: UITextView { get set }
    var profileImage: UIImageView { get set }
    func showAlert()
}

final class CreatePostViewController: UIViewController, CreatePostViewProtocol {
    
    
    var presenter: CreatePostPresenterProtocol?
    var arrayOfPickedImages: [UIImage] = []
    var arrayOfURL: [URL] = []
    
    private let titleLabel: GLabel = {
        let label = GLabel(text: "Create a new guide!",
                           font: .medium21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.height / 13, height: UIScreen.main.bounds.height / 13)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    
    private lazy var voiceButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "voice"), for: .normal)
        return btn
    }()
    
    var guideNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Add guide name..."
        tf.font = .medium15
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 0.8
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftViewMode = .always
        return tf
    }()
    
    var guideDescriptionTextField: UITextView = {
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 0.8
        return tf
    }()
    
    var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Image")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    

    private let selectLocationButton = GWhiteRectangleButton(title: "Select location")
    private let addMore = GWhiteRectangleButton(title: "Add more")
    
    private lazy var addVoiceButton: GWhiteRectangleButton = {
        let btn = GWhiteRectangleButton(title: "Add voice")
        btn.addTarget(self, action: #selector(chooseAudio), for: .touchUpInside)
        return btn
    }()
    
    private lazy var addPhotoButton: GWhiteRectangleButton = {
        let btn = GWhiteRectangleButton(title: "Add photo")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
        return btn
    }()
    
    private lazy var postButton: GWhiteRectangleButton = {
        let btn = GWhiteRectangleButton(title: "Post", backColor: .black, tintColor: .white)
        btn.titleLabel?.font = .medium21
        btn.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboard()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Success", message: "Post is ready to be read", preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertOK)
        present(alert, animated: true)
    }
    
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func chooseAudio() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.mp3], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    @objc func createPost() {
        presenter?.createPost()
    }
    
    @objc func choosePhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}

private extension CreatePostViewController {
    func setupView() {
        view.backgroundColor = .white
        let margin = view.layoutMarginsGuide
        view.addSubview(titleLabel)
        view.addSubview(profileImage)
        view.addSubview(guideNameTextField)
        view.addSubview(guideDescriptionTextField)
        view.addSubview(addPhotoButton)
        view.addSubview(addVoiceButton)
        view.addSubview(selectLocationButton)
        view.addSubview(addMore)
        view.addSubview(postButton)
        view.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: margin.topAnchor),

            guideNameTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 10),
            guideNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),

            profileImage.leadingAnchor.constraint(equalTo: guideNameTextField.trailingAnchor, constant: 25),
            margin.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            
            guideDescriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            guideDescriptionTextField.topAnchor.constraint(equalTo: guideNameTextField.bottomAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: guideDescriptionTextField.trailingAnchor, constant: 25),
            
            addPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            addPhotoButton.topAnchor.constraint(equalTo: guideDescriptionTextField.bottomAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: addPhotoButton.trailingAnchor, constant: 25),
            
            addVoiceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            addVoiceButton.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: addVoiceButton.trailingAnchor, constant: 25),
            
            selectLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            selectLocationButton.topAnchor.constraint(equalTo: addVoiceButton.bottomAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: selectLocationButton.trailingAnchor, constant: 25),
            
            
            postButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            view.trailingAnchor.constraint(equalTo: postButton.trailingAnchor, constant: 25),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: postButton.bottomAnchor, constant: 10),
            
            addMore.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            view.trailingAnchor.constraint(equalTo: addMore.trailingAnchor, constant: 25),
            postButton.topAnchor.constraint(equalTo: addMore.bottomAnchor, constant: 10),
            
            guideNameTextField.heightAnchor.constraint(equalToConstant: 50),
            guideDescriptionTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 11)
        ])
    }
}

    extension CreatePostViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        arrayOfPickedImages.append(image)
        presenter?.uploadImage(image: image)
        collectionView.reloadData()
        
        addVoiceButton.removeFromSuperview()
        selectLocationButton.removeFromSuperview()
        view.addSubview(addVoiceButton)
        view.addSubview(selectLocationButton)
        
        if voiceButton.isDescendant(of: view) {
            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
                collectionView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 10),
                view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 27),
                
                addVoiceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                addVoiceButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
                view.trailingAnchor.constraint(equalTo: addVoiceButton.trailingAnchor, constant: 25),
                
                voiceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                voiceButton.topAnchor.constraint(equalTo: addVoiceButton.bottomAnchor, constant: 10),
                view.trailingAnchor.constraint(equalTo: voiceButton.trailingAnchor, constant: 25),
                
                selectLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                selectLocationButton.topAnchor.constraint(equalTo: voiceButton.bottomAnchor, constant: 10),
                view.trailingAnchor.constraint(equalTo: selectLocationButton.trailingAnchor, constant: 25),
            ])
        } else {
            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
                collectionView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 10),
                view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 27),
                
                addVoiceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                addVoiceButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
                view.trailingAnchor.constraint(equalTo: addVoiceButton.trailingAnchor, constant: 25),
                
                selectLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                selectLocationButton.topAnchor.constraint(equalTo: addVoiceButton.bottomAnchor, constant: 10),
                view.trailingAnchor.constraint(equalTo: selectLocationButton.trailingAnchor, constant: 25),
            ])
        }
        
        
        
        dismiss(animated: true)
    }
}

extension CreatePostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfPickedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.setupImage(image: arrayOfPickedImages[indexPath.row])
        return cell
    }
    
    
}

extension CreatePostViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        presenter?.audio(urls: urls.first!)
        
        
        selectLocationButton.removeFromSuperview()
        
        view.addSubview(selectLocationButton)
        view.addSubview(voiceButton)
        NSLayoutConstraint.activate([
            voiceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            voiceButton.topAnchor.constraint(equalTo: addVoiceButton.bottomAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: voiceButton.trailingAnchor, constant: 25),
            
            selectLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            selectLocationButton.topAnchor.constraint(equalTo: voiceButton.bottomAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: selectLocationButton.trailingAnchor, constant: 25),
        ])
    }
}
