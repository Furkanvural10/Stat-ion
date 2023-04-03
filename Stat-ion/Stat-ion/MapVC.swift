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

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var stationMapView: MKMapView!
    let locationManager = CLLocationManager()
    let vc = UIViewController()
    
    
    @IBOutlet weak var showCurrentLocationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
        animation()
        createUser()
        
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
    
    private func configurationView(){
        navigationItem.hidesBackButton = true
        self.showCurrentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        self.showCurrentLocationButton.layer.cornerRadius = 23
        self.showCurrentLocationButton.backgroundColor = .white
        
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
    
    
    
}

extension MapVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let latitude = locations[0].coordinate.latitude
            let longitude = locations[0].coordinate.longitude
            let latitudeDelta = 0.1
            let longitudeDelta = 0.1
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.stationMapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
    }
}
