//
//  OnboardingCollectionViewCell.swift
//  Stat-ion
//
//  Created by furkan vural on 6.10.2023.
//

import UIKit
import Lottie

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    
    func configure(with slide: Slide) {
        titleLabel.text = slide.title
        getStartedButton.backgroundColor = slide.buttonColor
        getStartedButton.setTitle(slide.buttonTitle, for: .normal)
        
        let animation = LottieAnimation.named("first")
        animationView.animation = animation
        animationView.loopMode = .loop
        
        if !animationView.isAnimationPlaying {
            animationView.play()
        }
    }
    
    @IBAction func getStartedButtonClicked(_ sender: Any) {
        
    }
}
