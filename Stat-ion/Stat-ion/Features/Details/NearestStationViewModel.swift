//
//  NearestStationViewModel.swift
//  Stat-ion
//
//  Created by furkan vural on 15.09.2023.
//

import Foundation

protocol NearestStationViewModelInterface {
    func viewDidLoad()
}

final class NearestStationViewModel {
    weak var view: NearestStationViewInterface?
}

extension NearestStationViewModel: NearestStationViewModelInterface {
    
    func viewDidLoad() {
        view?.configurationView()
        view?.zipTwoArray()
    }
}
