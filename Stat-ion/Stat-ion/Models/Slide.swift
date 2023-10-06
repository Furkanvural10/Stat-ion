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
        .init(title: "Elektirikli aracın için şarj istasyonu bulmak artık çok kolay.", animationName: "first", buttonColor: .darkGray, buttonTitle: "Next"),
        .init(title: "Sana en yakın şarj istasyonunu haritadan seç ve rota oluştur.", animationName: "second", buttonColor: .darkGray, buttonTitle: "Next"),
        .init(title: "Hızlıca şarj et ve yolculuğa keyifle devam et.", animationName: "last", buttonColor: .darkGray, buttonTitle: "Get Started")
    ]
}
