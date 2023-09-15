//
//  MapViewModel.swift
//  Stat-ion
//
//  Created by furkan vural on 14.09.2023.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

protocol MapViewModelInterface {
    var mapView: MapViewInterface? { get set }
    func viewDidLoad()
    func createUser(on vc: UIViewController)
    func getStation(on vc: UIViewController)
    
    
}

final class MapViewModel {
    weak var mapView: MapViewInterface?
    
    
}

extension MapViewModel: MapViewModelInterface {
    
    
    func viewDidLoad() {
        mapView?.prepareView()
        mapView?.createAnonymousUser()
        mapView?.getStationFromDatabase()
    }
    
    func createUser(on vc: UIViewController) {
        FirebaseUserCreateFunction().createUser(on: vc)
    }
    
    func getStation(on vc: UIViewController) {
        FirebaseGetStation.getStation {  stationList in
            self.mapView?.didFetchStationData(stationList)
        }
    }
}
