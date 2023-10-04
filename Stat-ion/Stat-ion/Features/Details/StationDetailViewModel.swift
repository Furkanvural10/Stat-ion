//
//  StationDetailViewModel.swift
//  Stat-ion
//
//  Created by furkan vural on 15.09.2023.
//

import Foundation

protocol StationDetailViewModelInterface {
    var view: StationDetailViewInterface? { get set }
    
    func viewDidLoad()
    func openMaps(station: Station)
}

class StationDetailViewModel {
    weak var view: StationDetailViewInterface?
}

extension StationDetailViewModel: StationDetailViewModelInterface {
    
    func viewDidLoad() {
        view?.configurationView()
    }
    
    func openMaps(station: Station) {
        Maps.openMapsFromStationDetailVC(station: station)
    }
}
