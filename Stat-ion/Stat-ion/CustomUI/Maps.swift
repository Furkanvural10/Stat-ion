//
//  Maps.swift
//  Stat-ion
//
//  Created by furkan vural on 8.04.2023.
//

import Foundation
import UIKit

struct Maps {
    
    static func openMaps(station: Station){
        
        let urlString = "http://maps.apple.com/?daddr=\(station.geopoint.latitude),\(station.geopoint.longitude)&dirflg=d"
        
        if let url = URL(string: urlString){
            UIApplication.shared.open(url, options: [:], completionHandler: nil )
        }
    }
}
