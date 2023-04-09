import UIKit
import CoreLocation
import MapKit
import FirebaseAuth
import FirebaseFirestore



class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var stationMapView: MKMapView!
    @IBOutlet weak var showCurrentLocationButton: UIButton!
    @IBOutlet weak var stationFabIcon: UIButton!
    
    let locationManager = CLLocationManager()
    let vc = UIViewController()
    var latitude: Double?
    var longitude: Double?
    var annotations = [MKPointAnnotation]()
    var userLocation: CLLocation?
    var station: Station?
    var stationList = [Station]()
    var nearStation = [Station]()
    var selectedStation: Station?
    var distanceKM = [Double]()
    var oneDistanceKM: Double?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
        animation()
        createUser()
//        getStation()

     
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        getStation()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        getStation()
    }
    
    private func createUser(){FirebaseUserCreateFunction().createUser(on: self)}
    
    
    
    func getStation(){
     

                let database = Firestore.firestore()
                let _ = database.collection(FirebaseText.collectionStationDetail).getDocuments{ querySnapshot, error in
                    if error == nil {
                        for document in querySnapshot!.documents{
                            let geopoint    = document.get(FirebaseText.coordinate) as! GeoPoint
                            let stationName = document.get(FirebaseText.stationName) as! String
                            let stationType = document.get(FirebaseText.stationType) as! String
                            let soket1      = document.get(FirebaseText.soket1) as! String
                            let soket2      = document.get(FirebaseText.soket2) as! String

                            self.station    = Station(stationName: stationName, stationType: stationType, soket1: soket1, soket2: soket2, geopoint: geopoint)
                            self.stationList.append(self.station!)

                            let coordinate        = CLLocationCoordinate2D(latitude: geopoint.latitude, longitude: geopoint.longitude)
                            let annotation        = MKPointAnnotation()
                            annotation.coordinate = coordinate
                            self.annotations.append(annotation)
                            annotation.title      = stationName

                            if let image = Images.stationAssetImage {
                                let annotationView    = self.stationMapView.view(for: annotation)
                                annotationView?.image = image
                            }
                            self.stationMapView.addAnnotation(annotation)
                        }
                    }
                }
    }
    
    

    
    private func configurationView(){
        navigationItem.hidesBackButton = true
        self.showCurrentLocationButton.setImage(Images.locationFill, for: .normal)
        self.showCurrentLocationButton.layer.cornerRadius = self.showCurrentLocationButton.frame.width / 2
        self.showCurrentLocationButton.backgroundColor = .white
        self.showCurrentLocationButton.tintColor = .systemBlue
        
        self.stationFabIcon.setImage(Images.stationAssetImage, for: .normal)
        self.stationFabIcon.layer.cornerRadius = self.stationFabIcon.frame.width / 2
        self.stationFabIcon.backgroundColor = .black

        //MARK: Map
        self.stationMapView.delegate = self
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        self.stationMapView.showsUserLocation = true
        
    }
    
    private func animation(){
        stationMapView.alpha = Alpha.alpha0
        UIView.animate(withDuration: 2) {
            self.stationMapView.alpha = Alpha.alpha
        }
    }
    @IBAction func showCurrentLocation(_ sender: Any) {
        locationManager.startUpdatingLocation()
      
    }
    
    @objc private func showStationDetail(){
        
        SheetPresent.sheetPresentView(vc: self, identifier: "stationDetailVC", selectedStation: selectedStation!, distance: oneDistanceKM!)
        
    }
    
    @IBAction func showStations(_ sender: Any) {
        // MARK: Filter stations around userLocation 5km
        let maxDistance: CLLocationDistance = ValueInteger.filteringDistance // in meters
        
        let filteredAnnotations = annotations.filter { annotation in
            let annotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let distance = annotationLocation.distance(from: userLocation!)
            
            return distance <= maxDistance
        }
        
        
        
        //MARK: - Finding Near Station from filteredAnnotationsList and Add nearStation
        
        for anotation in filteredAnnotations{
            for i in stationList{
                if anotation.coordinate.longitude == i.geopoint.longitude{
                    nearStation.append(i)
                }
            }
        }
        
        // MARK: - Find nearestDistance
        
        for chargeStation in nearStation{
            let annotationLocation = CLLocation(latitude: chargeStation.geopoint.latitude, longitude: chargeStation.geopoint.longitude)
            let distance = annotationLocation.distance(from: userLocation!) / 1000.0
            distanceKM.append((distance * 10).rounded() / 10)
        }
        openNearestStationCustomSheet(choosedStations: nearStation, distanceKM: distanceKM)
    }
    
    func openNearestStationCustomSheet(choosedStations: [Station], distanceKM: [Double]){
        SheetPresent.sheetPresentNearestView(vc: self, identifier: "nearestStationVC", choosedStations: choosedStations, distanceKM: distanceKM)
    }
    
}

extension MapVC: CLLocationManagerDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annotationView = self.stationMapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
            let detailDisclosurebutton = UIButton(type: .detailDisclosure)
            detailDisclosurebutton.addTarget(self, action: #selector(showStationDetail), for: .touchUpInside)
            annotationView?.rightCalloutAccessoryView = detailDisclosurebutton
                        
        }else{
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = Images.stationAnotation
        annotationView?.contentMode = .scaleAspectFit
        
        return annotationView
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let latitude = locations[0].coordinate.latitude
            let longitude = locations[0].coordinate.longitude
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: ValueInteger.zoomLatitudeDelta, longitudeDelta: ValueInteger.zoomLongitudeDelta)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.stationMapView.setRegion(region, animated: true)
            self.userLocation = locations.last
            locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation {
               let latitude = annotation.coordinate.latitude
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



