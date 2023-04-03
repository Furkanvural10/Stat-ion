//
//  MapVC.swift
//  Stat-ion
//
//  Created by furkan vural on 2.04.2023.
//

import UIKit
import CoreLocation
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var stationMapView: MKMapView!
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
        animation()
        
    }
    
    private func configurationView(){
        navigationItem.hidesBackButton = true
        
        //MARK: Map
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
    }
}
