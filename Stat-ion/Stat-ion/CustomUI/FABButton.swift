//
//  FABButton.swift
//  Stat-ion
//
//  Created by furkan vural on 9.04.2023.
//

import Foundation
import UIKit

struct CustomFabButton {
    
    
    static func createStationFAB(stationFABButton: inout UIButton)-> UIButton{
        
        stationFABButton.setImage(Images.stationAssetImage, for: .normal)
        stationFABButton.layer.cornerRadius = stationFABButton.frame.width / 2
        stationFABButton.backgroundColor = .black
        return stationFABButton
        
    }
    
    static func createLocationFAB(currentLocationButton: inout UIButton) -> UIButton{
        currentLocationButton.setImage(Images.locationFill, for: .normal)
        currentLocationButton.layer.cornerRadius = currentLocationButton.frame.width / 2
        currentLocationButton.backgroundColor = .white
        currentLocationButton.tintColor = .systemBlue
        return currentLocationButton
    }
    
}
