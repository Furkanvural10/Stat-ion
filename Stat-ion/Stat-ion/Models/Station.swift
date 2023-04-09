//
//  Station.swift
//  Stat-ion
//
//  Created by furkan vural on 8.04.2023.
//

import Foundation
import FirebaseFirestore

struct Station {
    var stationName : String
    var stationType : String
    var soket1      : String
    var soket2      : String
    var geopoint    : GeoPoint
}
