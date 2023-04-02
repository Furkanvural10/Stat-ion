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

        // Do any additional setup after loading the view.
        stationMapView.delegate = self
        
    }

}

extension MapVC: MKMapViewDelegate{
    
}
