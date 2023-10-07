//
//  Slide.swift
//  Stat-ion
//
//  Created by furkan vural on 6.10.2023.
//

import Foundation
import UIKit

struct Slide {
    
    let title: String
    let animationName: String
    let buttonColor: UIColor
    let buttonTitle: String
    
    static let collection: [Slide] = [
        .init(title: "Finding a charging station for an electric vehicle is now very easy.", animationName: "first", buttonColor: .black, buttonTitle: "Next"),
        .init(title: "Select the nearest charging station from the map and create a route.", animationName: "second", buttonColor: .black, buttonTitle: "Next"),
        .init(title: "Charge quickly and continue your journey with pleasure.", animationName: "last", buttonColor: .black, buttonTitle: "Get Started")
    ]
}
