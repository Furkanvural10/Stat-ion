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
    func getStation()
    func showStationDetail(vc: UIViewController, identifier: String, selectedStation: Station, distance: Double)
    func showStations(annotationList: [MKPointAnnotation], userLocation: CLLocation?, stationList: [Station], nearStation: inout [Station], distanceKM: inout [Double]) -> ([Station], [Double])
    func showNearestView(vc: UIViewController, result: ([Station], [Double]))
    
    
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
    
    func getStation() {
        FirebaseGetStation.getStation {  stationList in
            self.mapView?.didFetchStationData(stationList)
        }
    }
    
    func showStationDetail(vc: UIViewController, identifier: String, selectedStation: Station, distance: Double) {
        SheetPresent.sheetPresentView(
        vc: vc,
        identifier: Text.stationDetailVC,
        selectedStation: selectedStation,
        distance: distance)
    }
 
    
    func showStations(annotationList: [MKPointAnnotation], userLocation: CLLocation?, stationList: [Station], nearStation: inout [Station], distanceKM: inout [Double]) -> ([Station], [Double]) {
        
        StationFilter.getFilteredStation(
                annotationList: annotationList,
                userLocation: userLocation!,
                stationList: stationList,
                nearStation: &nearStation,
                distanceKM: &distanceKM)
    }
    
    func showNearestView(vc: UIViewController, result: ([Station], [Double])) {
        SheetPresent.sheetPresentNearestView(
            vc: vc,
            identifier: Text.nearestStationVC,
            choosedStations: result.0,
            distanceKM: result.1
        )
    }
}
