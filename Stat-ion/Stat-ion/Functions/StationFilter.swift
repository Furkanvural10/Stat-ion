//
//  StationFilter.swift
//  Stat-ion
//
//  Created by furkan vural on 9.04.2023.
//

import Foundation
import CoreLocation
import MapKit

struct StationFilter {
    
     // MARK: Filter stations around userLocation 5km
     func getFilteredStation(annotationList: [MKPointAnnotation], userLocation: CLLocation?, stationList: [Station], nearStation: inout [Station], distanceKM: inout [Double]) -> ([Station], [Double]){
         
        let maxDistance: CLLocationDistance = ValueInteger.filteringDistance // in meters
        let filteredAnnotations = annotationList.filter { annotation in
            let annotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let distance = annotationLocation.distance(from: userLocation!)
            return distance <= maxDistance
        }
        
        for anotation in filteredAnnotations{
            for i in stationList{
                if anotation.coordinate.longitude == i.geopoint.longitude{
                    nearStation.append(i)
                }
            }
        }
        
        for chargeStation in nearStation{
            let annotationLocation = CLLocation(latitude: chargeStation.geopoint.latitude, longitude: chargeStation.geopoint.longitude)
            let distance = annotationLocation.distance(from: userLocation!) / 1000.0
            distanceKM.append((distance * 10).rounded() / 10)
        }
        
         return (nearStation, distanceKM)
    }
    
}
