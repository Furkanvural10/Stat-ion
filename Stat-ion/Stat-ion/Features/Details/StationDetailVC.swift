//
//  StationDetailVC.swift
//  Stat-ion
//
//  Created by furkan vural on 3.04.2023.
//

import UIKit

class StationDetailVC: UIViewController {
    
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var carItem: UIBarButtonItem!
    @IBOutlet weak var stationTypeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var firstSoketLabel: UILabel!
    @IBOutlet weak var secondSoketLabel: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var firstSoketType: UILabel!
    @IBOutlet weak var secondSoketType: UILabel!
    
    var stationDetail: Station?
    var distance : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
    }
    
    private func configurationView(){
        
        let isSocket1Exist = stationDetail?.soket1 == "-" ? false : true
        let isSocket2Exist = stationDetail?.soket2 == "-" ? false : true
        
        self.navigationBar.topItem?.title = stationDetail?.stationName
        self.carItem.image = UIImage(systemName: "car.fill")
        self.stationTypeLabel.text = "Station Type: \(stationDetail!.stationType)"
        self.stationTypeLabel.font = .systemFont(ofSize: 14)
        self.stationTypeLabel.alpha = 0.8
        
        self.distanceView.layer.cornerRadius = 5
        self.distanceView.backgroundColor = .systemBlue
        self.distanceLabel.text = "\(self.distance!) KM"
        self.distanceLabel.textColor = .white
        self.distanceLabel.font = .systemFont(ofSize: 14)
        
        self.firstView.layer.cornerRadius = 10
        self.secondView.layer.cornerRadius = 10
        
        self.firstSoketLabel.text = "Soket-1"
        self.firstSoketLabel.font = .systemFont(ofSize: 15)
        self.firstSoketLabel.textColor = isSocket1Exist ? .black : .white
        self.secondSoketLabel.text = "Soket-2"
        self.secondSoketLabel.font = .systemFont(ofSize: 15)
        self.secondSoketLabel.textColor = isSocket2Exist ? .black : .white
 
        self.firstView.backgroundColor = isSocket1Exist  ? .systemGreen : .systemGray5
        self.secondView.backgroundColor = isSocket2Exist ? .systemGreen : .systemGray5
        let soket1 = isSocket1Exist ? stationDetail?.soket1 : "Mevcut Değil"
        let soket2 = isSocket2Exist ? stationDetail?.soket2 : "Mevcut Değil"
        let replaceTextSoket1 = soket1!.replacingOccurrences(of: ", ", with: "\n•")
        let replaceTextSoket2 = soket2!.replacingOccurrences(of: ", ", with: "\n•")
        self.firstSoketType.text = "•\(replaceTextSoket1)"
        self.secondSoketType.text = "•\(replaceTextSoket2)"
        self.firstSoketType.numberOfLines = 0
        self.secondSoketType.numberOfLines = 0
 
        self.firstSoketType.alpha = 0.9
        self.secondSoketType.alpha = 0.9
    }
    
    @IBAction func openMaps(_ sender: Any) {
        Maps.openMapsFromStationDetailVC(station: stationDetail!)
    }
}
