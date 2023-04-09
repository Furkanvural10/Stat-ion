//
//  SheetPresent.swift
//  Stat-ion
//
//  Created by furkan vural on 9.04.2023.
//

import Foundation
import UIKit

struct SheetPresent {
    
    static func sheetPresentView(vc: UIViewController, identifier: String, selectedStation: Station, distance: Double){
        if let stationDetailVC = vc.storyboard?.instantiateViewController(withIdentifier: identifier) as? StationDetailVC{
            if let sheet = stationDetailVC.sheetPresentationController{
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = Radius.cornerRadius15
            }
            stationDetailVC.stationDetail = selectedStation
            stationDetailVC.distance      = distance
            vc.navigationController?.present(stationDetailVC, animated: true)
        }
    }
    
    static func sheetPresentNearestView(vc: UIViewController, identifier: String, choosedStations: [Station], distanceKM: [Double]){
        if let nearestStationVC = vc.storyboard?.instantiateViewController(withIdentifier: identifier) as? NearestStationVC{
            if let sheet = nearestStationVC.sheetPresentationController{
                sheet.detents               = [.medium(),]
                sheet.preferredCornerRadius = Radius.cornerRadius15
            }
            nearestStationVC.station    = choosedStations
            nearestStationVC.distanceKM = distanceKM
            vc.navigationController?.present(nearestStationVC, animated: true)
        }
    }
}
