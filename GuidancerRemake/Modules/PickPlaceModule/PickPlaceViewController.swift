import UIKit
import MapKit

protocol PickPlaceViewProtocol: AnyObject {
    var delegate: isAbleToReceiveData? { get set }
}

class PickPlaceViewController: UIViewController {
    
    var presenter: PickPlacePresenterProtocol?
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var delegate: isAbleToReceiveData?

    private let currentAdressLabel: UILabel = {
        let label = UILabel()
        label.font = .medium21
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pinView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var doneButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "hands.sparkles.fill"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private lazy var toBackBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                                   style: .plain,
                                   target: self,
                                   action: nil)
        item.tintColor = .black
        return item
    }()
    
    private let imageOfPin: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "map")
        view.tintColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.leftBarButtonItem = toBackBarButtonItem
       // это как притяигивать изначально по адресу понял
//           let geocoder = CLGeocoder()
//           geocoder.geocodeAddressString("Александровск, Кирова, 7") { placemarks, error in
//               if let error = error {
//                   print(error)
//                   return
//               }
//               guard let placemarks = placemarks else { return }
//
//               let placemark = placemarks.first
//
//               let annotation = MKPointAnnotation()
//               annotation.title = "place.name"
//               annotation.subtitle = "place.type"
//
//               guard let placemarkLocation = placemark?.location else { return }
//
//               annotation.coordinate = placemarkLocation.coordinate
//
//
//               self.mapView.showAnnotations([annotation], animated: true)
//               self.mapView.selectAnnotation(annotation, animated: true)
//           }
       
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
       let latitude = mapView.centerCoordinate.latitude
       let longitude = mapView.centerCoordinate.longitude
       return CLLocation(latitude: latitude, longitude: longitude)
   }
    
    @objc func closeController() {
        delegate?.makeConstraints()
        
        dismiss(animated: true)
    }
}

extension PickPlaceViewController: PickPlaceViewProtocol {
}

private extension PickPlaceViewController {
    func setupView() {
        view.addSubview(mapView)
        mapView.addSubview(currentAdressLabel)
        mapView.addSubview(pinView)
        mapView.addSubview(doneButton)
        pinView.addSubview(imageOfPin)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            
            currentAdressLabel.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor, constant: 50),
            currentAdressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: currentAdressLabel.trailingAnchor, constant: 20),
            
            doneButton.topAnchor.constraint(equalTo: pinView.bottomAnchor, constant: 50),
            pinView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            pinView.heightAnchor.constraint(equalToConstant: 50),
            pinView.widthAnchor.constraint(equalToConstant: 40),
            
            mapView.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 100),
            doneButton.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.widthAnchor.constraint(equalToConstant: 40),
            
            imageOfPin.leadingAnchor.constraint(equalTo: pinView.leadingAnchor),
            imageOfPin.topAnchor.constraint(equalTo: pinView.topAnchor),
            pinView.trailingAnchor.constraint(equalTo: imageOfPin.trailingAnchor),
            pinView.bottomAnchor.constraint(equalTo: imageOfPin.bottomAnchor)
        ])
    }
}

extension PickPlaceViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let center = getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        
        geocoder.cancelGeocode()
        
        geocoder.reverseGeocodeLocation(center) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            let cityName = placemark?.locality
            let streetName = placemark?.thoroughfare
            let buildNumber = placemark?.subThoroughfare
          
            DispatchQueue.main.async {
                if streetName != nil && buildNumber != nil && cityName != nil {
                    self.currentAdressLabel.text = "\(cityName!), \(streetName!), \(buildNumber!)"
                    self.delegate?.pass(data: "\(cityName!), \(streetName!), \(buildNumber!))")
                } else if streetName != nil && buildNumber != nil {
                    self.currentAdressLabel.text = "\(streetName!), \(buildNumber!)"
                    self.delegate?.pass(data: "\(streetName!), \(buildNumber!)")
                } else {
                    self.currentAdressLabel.text = "Позиция не выбрана"
                    self.delegate?.pass(data: "Позиция не выбрана")
                    }
            }
        }
    }
}
