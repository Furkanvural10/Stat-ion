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
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
        animation()
        
    }
    
    private func configurationView(){
        navigationItem.hidesBackButton = true
        stationMapView.delegate = self
    }
    
    private func animation(){
        stationMapView.alpha = 0
        UIView.animate(withDuration: 2) {
            self.stationMapView.alpha = 1
        }
    }

}

extension MapVC: MKMapViewDelegate{
    
}
