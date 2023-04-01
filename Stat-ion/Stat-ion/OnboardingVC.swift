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
        self.onboardingImageView.image = UIImage(named: "Onboarding")
        self.onboardingImageView.contentMode = .scaleToFill
    }
    
    
    @IBAction func startButton(_ sender: Any) {
    }
    
    

}

