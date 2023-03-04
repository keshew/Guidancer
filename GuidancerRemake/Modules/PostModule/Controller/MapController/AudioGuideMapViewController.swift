import UIKit
import MapKit

final class AudioGuideMapViewController: UIViewController {
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttomItem: UIBarButtonItem = {
       let item = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(dissmissVC))
       item.tintColor = .black
       return item
   }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBarButtonItem()
    }
}

private extension AudioGuideMapViewController {
    func setupView() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: mapView.bottomAnchor)
        ])
    }
    
     func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = buttomItem
    }
    
    @objc func dissmissVC() {
        dismiss(animated: true)
    }
}
