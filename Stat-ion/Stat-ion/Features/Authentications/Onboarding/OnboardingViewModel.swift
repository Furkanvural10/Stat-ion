//
//  OnboardingViewModel.swift
//  Stat-ion
//
//  Created by furkan vural on 14.09.2023.
//

import Foundation

protocol OnboardingViewModelInterface {
    var onboardingView: OnboardingViewInterface? { get set }
    
    func viewDidLoad()
    func checkOnboardingPageSeen()
    func endingOnboardingPage()
}

final class OnboardingViewModel {
    weak var onboardingView: OnboardingViewInterface?
    
}

extension OnboardingViewModel: OnboardingViewModelInterface {
   
    
    func viewDidLoad() {
        onboardingView?.prepareOnboardingView()
        
    }
    
    func checkOnboardingPageSeen() {
        let result = UserDefaults.standard.object(forKey: Text.onboardingSeen)
        if (result as? Bool) != nil {
            onboardingView?.performSegue(identifier: Text.toChargeStationMapVC)
        }
    }
    
    func endingOnboardingPage() {
        UserDefaults.standard.set(true, forKey: Text.onboardingSeen)
        onboardingView?.endingOnboardingPage()
    }
}
