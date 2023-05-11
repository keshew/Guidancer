import UIKit
import MapKit
import CoreLocation

protocol MapsViewProtocol: AnyObject {
    func sucsess(array: Post)
    func faillure(error: Error)
    var arrayOfLocations: [String] { get set }
}

class MapsViewController: UIViewController, MapsViewProtocol {
    
    var presenter: MapsPresenterProtocol?
    let manager = CLLocationManager()
    
    var arrayNumbers: [Int] = []
    var arrayOfLocations: [String] = []
    var sahar: [Int: CLLocationCoordinate2D] = [:]
    
    private lazy var directionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "direction"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(showInfo), for: .touchUpInside)
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
        seeLocation()
        presenter?.getAllLoaction()
    }
    
    func sucsess(array: Post) {
        for i in array {
            arrayOfLocations.append(i.location ?? "")
            let geocoder = CLGeocoder()
          
            geocoder.geocodeAddressString(i.location!) { placemarks, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let placemarks = placemarks else { return }

                let placemark = placemarks.first

                let annotation = MKPointAnnotation()
                annotation.title = "place.name"
                annotation.subtitle = "place.type"

                guard let placemarkLocation = placemark?.location else { return }

                annotation.coordinate = placemarkLocation.coordinate

                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
      
    }
    
    func faillure(error: Error) {
        //make alert
        print("Error is", error)
    }

    @objc func showInfo() {
        let controller = PlacesViewController()
        controller.sheetPresentationController?.preferredCornerRadius = 20
        present(controller, animated: true)
    }
    
    func seeLocation() {
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
        //user coordinate
//        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        
//        //metrics to zoom
//        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        
//        //its just region what we will see
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        mapView.setRegion(region, animated: true)
//        
//        //make annotation with custom coordanates
//        let annotation = MKPointAnnotation()
//        let cistomCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude + 0.0011, longitude: location.coordinate.longitude)
//        annotation.coordinate = cistomCoordinate
//        let annotation2 = MKPointAnnotation()
//        let cistomCoordinate2 = CLLocationCoordinate2D(latitude: location.coordinate.latitude + 0.0011, longitude: location.coordinate.longitude + 0.200001)
//        annotation2.coordinate = cistomCoordinate2
//   
////        let ettst = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 10, longitudinalMeters: 1000)
//        //MY PLACE
//        let annotationMY =  MKPointAnnotation()
//        annotationMY.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude + 0.001, longitude: location.coordinate.longitude + 0.10000)
//        mapView.addAnnotations([annotation,annotation2,annotationMY])
//
////        mapView.setRegion(ettst, animated: true)
//        
//        for i in mapView.annotations {
//            let annotationLocation = CLLocation(latitude: i.coordinate.latitude, longitude: i.coordinate.longitude)
//            let userLocation2 = CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
//            let distance = Int(userLocation2.distance(from: annotationLocation))
////            print("DISTANCE FROM \(i) TO ME IS", distance)
//            arrayNumbers.append(distance)
//            let coordinate = CLLocationCoordinate2D(latitude: i.coordinate.latitude, longitude: i.coordinate.longitude)
//            sahar[distance] = coordinate
//            
//            
//        }
//        
//        let sortedYourArray = sahar.sorted( by: { $0.1.latitude < $1.1.latitude })
//        let test = MKCoordinateRegion(center: sortedYourArray.first!.value, latitudinalMeters: 1000, longitudinalMeters: 1000)
//        mapView.setRegion(test, animated: true)
        
//        let geocoder = CLGeocoder()
//
//        geocoder.geocodeAddressString("Александровск, Кирова, 7") { placemarks, error in
//            if let error = error {
//                print(error)
//                return
//            }
//            guard let placemarks = placemarks else { return }
//
//            let placemark = placemarks.first
//
//            let annotation = MKPointAnnotation()
//            annotation.title = "place.name"
//            annotation.subtitle = "place.type"
//
//            guard let placemarkLocation = placemark?.location else { return }
//
//            annotation.coordinate = placemarkLocation.coordinate
//
//            self.mapView.showAnnotations([annotation], animated: true)
//            self.mapView.selectAnnotation(annotation, animated: true)
//        }
    }
}

extension MapsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
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
