//
//  MapVC.swift
//  Stat-ion
//
//  Created by furkan vural on 2.04.2023.
//

import UIKit
import CoreLocation
import MapKit
import FirebaseAuth
import FirebaseFirestore

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var stationMapView: MKMapView!
    let locationManager = CLLocationManager()
    let vc = UIViewController()
    var latitude: Double?
    var longitude: Double?
    var annotations = [MKPointAnnotation]()
    @IBOutlet weak var stationFabIcon: UIButton!
    
    
    @IBOutlet weak var showCurrentLocationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurationView()
        animation()
        
        createUser()
        getStation()
        
    }
    
    private func createUser(){
        let currentUser = Auth.auth().currentUser
        if currentUser == nil {
            Auth.auth().signInAnonymously { data, error in
                if error != nil{
                    print("SHOW Error")
                }
            }
        }
    }
    
    func getStation(){
        
        let database = Firestore.firestore()
        let collection = database.collection("stationDetail").getDocuments{ querySnapshot, error in
            if error == nil {
                
                for document in querySnapshot!.documents{
                    let geopoint = document.get("coordinate") as! GeoPoint
                    let title = document.get("stationName") as! String
                    let coordinate = CLLocationCoordinate2D(latitude: geopoint.latitude, longitude: geopoint.longitude)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    self.annotations.append(annotation)
                    annotation.title = title
                    self.stationMapView.addAnnotation(annotation)
                }
                
            }
        }
    }
    
    private func configurationView(){
        navigationItem.hidesBackButton = true
        self.showCurrentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        self.showCurrentLocationButton.layer.cornerRadius = self.showCurrentLocationButton.frame.width / 2
        self.showCurrentLocationButton.backgroundColor = .black
        self.showCurrentLocationButton.tintColor = .white
        
        self.stationFabIcon.setImage(UIImage(systemName: "battery.100.bolt"), for: .normal)
        self.stationFabIcon.layer.cornerRadius = self.stationFabIcon.frame.width / 2
        self.stationFabIcon.backgroundColor = .black
        self.stationFabIcon.tintColor = .white
        
        
        //MARK: Map
        self.stationMapView.delegate = self
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        self.stationMapView.showsUserLocation = true
        
    }
    
    private func animation(){
        stationMapView.alpha = 0
        UIView.animate(withDuration: 2) {
            self.stationMapView.alpha = 1
        }
    }
    @IBAction func showCurrentLocation(_ sender: Any) {
        locationManager.startUpdatingLocation()
      
    }
    
    private func showStationDetail(){
        if let stationDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "stationDetailVC") as? StationDetailVC{
            if let sheet = stationDetailVC.sheetPresentationController{
                sheet.detents = [.medium(), .large()]
                sheet.preferredCornerRadius = 15
            }
            self.navigationController?.present(stationDetailVC, animated: true)
        }
        
    }
    
    @IBAction func showStations(_ sender: Any) {
        self.stationMapView.showAnnotations(self.annotations, animated: true)
    }
    
   
    
    
}

extension MapVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let latitude = locations[0].coordinate.latitude
            let longitude = locations[0].coordinate.longitude
            let latitudeDelta = 0.01
            let longitudeDelta = 0.01
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.stationMapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
    }
}

