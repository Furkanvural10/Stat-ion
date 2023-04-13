import Foundation
import UIKit

struct Maps {
    
    static func openMapsFromStationDetailVC(station: Station){
        let latitude  = station.geopoint.latitude
        let longitude = station.geopoint.longitude
        let urlString = "http://maps.apple.com/?daddr=\(latitude),\(longitude)&dirflg=d"
        if let url    = URL(string: urlString){
            UIApplication.shared.open(url, options: [:], completionHandler: nil )
        }
    }
    
    static func openMapFromNearestVC(station: NearestStation){
        let latitude  = station.geopoint.latitude
        let longitude = station.geopoint.longitude
        let urlString = "http://maps.apple.com/?daddr=\(latitude),\(longitude)&dirflg=d"
        if let url    = URL(string: urlString){
            UIApplication.shared.open(url, options: [:], completionHandler: nil )
        }
    }
}
