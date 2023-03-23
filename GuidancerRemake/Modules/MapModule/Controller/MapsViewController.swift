import UIKit
import MapKit
import CoreLocation

protocol MapsViewProtocol: AnyObject {
}

class MapsViewController: UIViewController, MapsViewProtocol {
    
    var presenter: MapsPresenterProtocol?
    let manager = CLLocationManager()
    
    private lazy var directionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "direction"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(seeLocation), for: .touchUpInside)
        return btn
    }()
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.delegate = self
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
        view.backgroundColor = .white
        navigationItem.title = "ITS MAP CONTROLLER"
        setupView()
        setupBarButtonItem()
    }
    
    @objc func seeLocation() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

private extension MapsViewController {
    func setupView() {
        view.addSubview(mapView)
        mapView.addSubview(directionButton)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            
            mapView.bottomAnchor.constraint(equalTo: directionButton.bottomAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: directionButton.trailingAnchor, constant: 20),
            directionButton.heightAnchor.constraint(equalToConstant: 50),
            directionButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = buttomItem
    }
    
    @objc func dissmissVC() {
        dismiss(animated: true)
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
        
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}

extension MapsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            print("GELP")
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            //Create View
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            //Assign annotation
            annotationView?.annotation = annotation
        }
        
        
        annotationView?.image = UIImage(named: "pin")
        
        
        return annotationView
    }
}
