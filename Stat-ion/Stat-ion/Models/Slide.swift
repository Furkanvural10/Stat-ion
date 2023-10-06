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
        .init(title: "Title-1", animationName: "", buttonColor: .yellow, buttonTitle: "Next"),
        .init(title: "Title-2", animationName: "", buttonColor: .green, buttonTitle: "Finished"),
    ]
}
