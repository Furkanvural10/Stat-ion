import UIKit
import CoreLocation
import MapKit
import FirebaseAuth
import FirebaseFirestore

protocol MapViewInterface: AnyObject {
    
    func prepareView()
    func getStationFromDatabase()
    func createAnonymousUser()
    func didFetchStationData(_ stationList: [Station])
    func showStationDetails()
}

final class MapVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet private weak var stationMapView            : MKMapView!
    @IBOutlet private weak var showCurrentLocationButton : UIButton!
    @IBOutlet private weak var stationFabIcon            : UIButton!
    
    private let locationManager = CLLocationManager()
    private let vc              = UIViewController()
    private var latitude        : Double?
    private var longitude       : Double?
    private var annotations     = [MKPointAnnotation]()
    private var userLocation    : CLLocation?
    private var station         : Station?
    private var stationList     = [Station]()
    private var nearStation     = [Station]()
    private var selectedStation : Station?
    private var distanceKM      = [Double]()
    private var oneDistanceKM   : Double?
    
    private lazy var mapViewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewModel.mapView = self
        mapViewModel.viewDidLoad()
    }
    
    private func createUser() {
        mapViewModel.createUser(on: self)
    }
    
    private func getStation() {
        mapViewModel.getStation()
    }
    
    private func configurationView(){
        navigationItem.hidesBackButton = true
        
        self.showCurrentLocationButton = CustomFabButton.createLocationFAB(currentLocationButton: &self.showCurrentLocationButton)
        
        self.stationFabIcon = CustomFabButton.createStationFAB(stationFABButton: &self.stationFabIcon)
        
        // MARK: - Map
        self.stationMapView.showsUserLocation = true
        self.stationMapView.delegate          = self
        self.locationManager.delegate         = self
        self.locationManager.desiredAccuracy  = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    private func animation() {
        stationMapView.alpha = Alpha.alpha0
        UIView.animate(withDuration: 2) {
            self.stationMapView.alpha = Alpha.alpha
        }
    }
    
    @IBAction func showCurrentLocation(_ sender: Any) { locationManager.startUpdatingLocation() }
    
    @objc private func showStationDetail() {
        
        print(selectedStation!)
        print(oneDistanceKM!)
        mapViewModel.showStationDetail(vc: self, identifier: Text.stationDetailVC, selectedStation: selectedStation!, distance: oneDistanceKM!)
    }
    
    @IBAction func showStations(_ sender: Any) {
        
        let result = mapViewModel.showStations(
            annotationList: annotations,
            userLocation: userLocation,
            stationList: stationList,
            nearStation: &nearStation,
            distanceKM: &distanceKM
        )
//        print("Result :\(result.0) \(result.1)")
        mapViewModel.showNearestView(vc: self, result: result)
    }
}

extension MapVC: CLLocationManagerDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = self.stationMapView.dequeueReusableAnnotationView(withIdentifier: Text.custom)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Text.custom)
            annotationView?.canShowCallout = true
            let detailDisclosurebutton     = UIButton(type: .detailDisclosure)
            detailDisclosurebutton.addTarget(self, action: #selector(showStationDetail), for: .touchUpInside)
            annotationView?.rightCalloutAccessoryView = detailDisclosurebutton
        } else {annotationView?.annotation = annotation}
        
        annotationView?.image = Images.stationAnotation
        annotationView?.contentMode = .scaleAspectFit
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude    = locations[0].coordinate.latitude
        let longitude   = locations[0].coordinate.longitude
        let coordinate  = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span        = MKCoordinateSpan(latitudeDelta: ValueInteger.zoomLatitudeDelta, longitudeDelta: ValueInteger.zoomLongitudeDelta)
        let region      = MKCoordinateRegion(center: coordinate, span: span)
        self.stationMapView.setRegion(region, animated: true)
        self.userLocation = locations.last
        locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation    = view.annotation {
            let latitude  = annotation.coordinate.latitude
            let longitude = annotation.coordinate.longitude
            
            for station in stationList{
                if station.geopoint.latitude == latitude && station.geopoint.longitude == longitude{
                    self.selectedStation = station
                    break
                }
            }
        }
        
        let annotationLocation = CLLocation(latitude: selectedStation!.geopoint.latitude, longitude: selectedStation!.geopoint.longitude)
        var distance = annotationLocation.distance(from: userLocation!) / 1000
        distance = (distance * 10).rounded() / 10
        self.oneDistanceKM = distance
    }
}

extension MapVC: MapViewInterface {
   
    
    func showStationDetails() {
        showStationDetail()
    }
    
    
    func didFetchStationData(_ stationList: [Station]) {
        self.stationList = stationList
        for i in self.stationList {
            let coordinate        = CLLocationCoordinate2D(
                latitude:  i.geopoint.latitude,
                longitude: i.geopoint.longitude)
            let annotation        = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            self.annotations.append(annotation)
            annotation.title      = i.stationName
            if let image = Images.stationAssetImage {
                let annotationView    = self.stationMapView.view(for: annotation)
                annotationView?.image = image
            }
            self.stationMapView.addAnnotation(annotation)
        }
    }
    
    
    func createAnonymousUser() {
        createUser()
    }
    
    func prepareView() {
        configurationView()
        animation()
    }
    
    func getStationFromDatabase() {
        getStation()
    }
    
}
