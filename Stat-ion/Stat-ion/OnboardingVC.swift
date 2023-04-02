//
//  ViewController.swift
//  Stat-ion
//
//  Created by furkan vural on 1.04.2023.
//

import UIKit
import MapKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var onboardingImageView: UIImageView!
    

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnboardingView()
    }
    
    private func configureOnboardingView(){
        
        let cornerRadius: CGFloat = 20
        let fontSize: CGFloat = 25
        let labelColor: UIColor = .white
        let temporaryText = "Lorem Ipsum Der Ao"
        
        //MARK: - ImageView Config
        self.onboardingImageView.image = UIImage(named: "Onboarding")
        self.onboardingImageView.contentMode = .scaleToFill
        
        
        //MARK: - View Config
        self.mainView.layer.cornerRadius = cornerRadius
        
        
        //MARK: - MapView Config
        self.mapView.layer.cornerRadius = cornerRadius
        
        //MARK: - Labels Config
        self.firstLabel.textColor = labelColor
        self.firstLabel.font = .boldSystemFont(ofSize: fontSize)
        self.firstLabel.text = temporaryText
        self.secondLabel.textColor = labelColor
        self.secondLabel.font = .boldSystemFont(ofSize: fontSize)
        self.secondLabel.text = temporaryText
        self.thirdLabel.textColor = labelColor
        self.thirdLabel.font = .boldSystemFont(ofSize: fontSize)
        self.thirdLabel.text = temporaryText
        
        //MARK: - StartButton Config
        self.startButton.tintColor = .black
        self.startButton.setTitle("Başla", for: .normal)
        
        let overlay = UIView(frame: onboardingImageView.bounds)
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.4
        onboardingImageView.addSubview(overlay)
        
        
    }
    
    
    @IBAction func startButton(_ sender: Any) {
    }
    
    

}

