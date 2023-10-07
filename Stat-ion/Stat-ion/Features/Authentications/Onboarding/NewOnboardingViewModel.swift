//
//  NewOnboardingViewModel.swift
//  Stat-ion
//
//  Created by furkan vural on 7.10.2023.
//

import Foundation
//
//  OnboardingViewModel.swift
//  Stat-ion
//
//  Created by furkan vural on 14.09.2023.
//

import Foundation

protocol OnboardingViewModelInterface {
    var view: OnboardingViewInterface? { get set }
    
    func viewDidLoad()
    func checkOnboardingPageSeen()
    func handleActionButtonTapped(at indexPath: IndexPath)
    
}

final class OnboardingViewModel {
    weak var view: OnboardingViewInterface2?
    private let slides: [Slide] = Slide.collection
    
    
}

extension OnboardingViewModel: OnboardingViewModelInterface {
    
    
    func viewDidLoad() {
        view?.prepareOnboardingView()
        
    }
    
    func checkOnboardingPageSeen() {
        let result = UserDefaults.standard.object(forKey: Text.onboardingSeen)
        if (result as? Bool) != nil {
            view?.performSegue(identifier: Text.toChargeStationMapVC)
        }
    }
    
    func endingOnboardingPage() {
        print("Tıklıyorum ve view: \(view!)")
        UserDefaults.standard.set(true, forKey: Text.onboardingSeen)
        view?.performSegue(identifier: Text.toChargeStationMapVC)
        
        
    }
    
    func handleActionButtonTapped(at indexPath: IndexPath) {
        if indexPath.item == slides.count - 1 {
            // In the last items
            endingOnboardingPage()
            
        } else {
            let nextItem = indexPath.item + 1
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            
            view?.handleActionButtonTapped(at: indexPath, nextIndexPath: nextIndexPath, nextItem: nextItem)
            
            
        }
    }
}
