import UIKit

protocol GuestViewProtocol: AnyObject {
    func sucsess()
    func faillure(error: Error)
}

class GuestViewController: ProfileViewController {

    var presenters: GuestPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenters?.getPosts()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenters?.viewModel?.postInforamtion?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = presenters?.viewModel?.postInforamtion?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchScreenCollectionViewCell.identifier, for: indexPath) as! SearchScreenCollectionViewCell
        cell.setupContent(post: .mock,
                          image: model?.imageUrl ?? "https://upload.wikimedia.org/wikipedia/commons/8/85/Saint_Basil%27s_Cathedral_and_the_Red_Square.jpg",
                          cityName: (model?.title)!,
                          descriptionOfPlace: (model?.text)!,
                          numberOfLikes: model?.v ?? 0)
//        viewOfProfile.setupUserInforamtion(image: model?.author?.avatarURL, nickname: model?.author?.nickname ?? "")
        return cell
    }
}

private extension GuestViewController {
     func setupView() {
        followButton.isHidden = false
    }
}

extension GuestViewController: GuestViewProtocol {
}
