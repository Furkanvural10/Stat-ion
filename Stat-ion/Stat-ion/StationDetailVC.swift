//
//  StationDetailVC.swift
//  Stat-ion
//
//  Created by furkan vural on 3.04.2023.
//

import UIKit

class StationDetailVC: UIViewController {
    
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configurationView()
    }
    
    private func configurationView(){
        self.navigationBar.topItem?.title = "İstasyonun İsmi"
        self.carItem.image = UIImage(systemName: "car.fill")
        self.stationTypeLabel.text = "Station Type: N22"
        self.stationTypeLabel.font = .systemFont(ofSize: 14)
        self.stationTypeLabel.alpha = 0.8
        
        self.distanceLabel.text = "12.4 KM"
        self.distanceLabel.alpha = 0.8
        self.distanceLabel.font = .systemFont(ofSize: 14)
        
        self.firstView.layer.cornerRadius = 10
        self.secondView.layer.cornerRadius = 10
        
        self.firstSoketLabel.text = "Soket-1"
        self.firstSoketLabel.textColor = .black
        self.secondSoketLabel.text = "Soket-2"
        self.secondSoketLabel.textColor = .black
        
        let text = "380 V, 32 A, 3 Faz AC"
        let replaceText = text.replacingOccurrences(of: ", ", with: "\n•")
        self.firstSoketType.text = "•\(replaceText)"
        self.secondSoketType.text = "•\(replaceText)"
        self.firstSoketType.numberOfLines = 0
        self.secondSoketType.numberOfLines = 0
        
        
        self.firstSoketType.alpha = 0.9
        self.secondSoketType.alpha = 0.9
    }
    



}
