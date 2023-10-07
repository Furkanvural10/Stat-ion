import Foundation
import UIKit

struct SheetPresent {
    
    static func sheetPresentView(vc: UIViewController, identifier: String, selectedStation: Station, distance: Double) {
        print("SheetPresentView calıstı")
        print(identifier)
        
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
    
    static func sheetPresentNearestView(vc: UIViewController, identifier: String, choosedStations: [Station], distanceKM: [Double]) {
        print("sheetPresentNearestView calıstı")
        
        if let nearestStationVC = vc.storyboard?.instantiateViewController(withIdentifier: identifier) as? NearestStationVC {
            print("Optional check \(nearestStationVC)")
            if let sheet = nearestStationVC.sheetPresentationController {
                print("sheet \(sheet) vc: \(vc)")
                sheet.detents               = [.medium(),]
                sheet.preferredCornerRadius = Radius.cornerRadius15
            }
            nearestStationVC.station    = choosedStations
            nearestStationVC.distanceKM = distanceKM
            vc.navigationController?.present(nearestStationVC, animated: true)
        }
    }
}
