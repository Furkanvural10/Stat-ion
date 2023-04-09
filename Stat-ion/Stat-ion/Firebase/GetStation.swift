//
//  GetStation.swift
//  Stat-ion
//
//  Created by furkan vural on 8.04.2023.
//

import Foundation
import FirebaseFirestore
import MapKit


struct FirebaseGetStation {
    
    static func getStation(completion: @escaping ([Station]) -> Void) {
        var station : Station?
        var stationList = [Station]()
        
            let database = Firestore.firestore()
            let _ = database.collection(FirebaseText.collectionStationDetail).getDocuments{ querySnapshot, error in
            if error == nil {
                for document in querySnapshot!.documents{
                    let geopoint    = document.get(FirebaseText.coordinate) as! GeoPoint
                    let stationName = document.get(FirebaseText.stationName) as! String
                    let stationType = document.get(FirebaseText.stationType) as! String
                    let soket1      = document.get(FirebaseText.soket1) as! String
                    let soket2      = document.get(FirebaseText.soket2) as! String
                    
                    station    = Station(stationName: stationName, stationType: stationType, soket1: soket1, soket2: soket2, geopoint: geopoint)
                    stationList.append(station!)
                    
                }
                completion(stationList)
            }
        }
        
    }
}
