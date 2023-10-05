//
//  Stat-ion
//
//  Created by furkan vural on 5.10.2023.
//

import UIKit

protocol OnboardingViewInterface2 {
    func prepareView()
}

final class OnboardingViewController: UIViewController {
    
    
    @IBOutlet weak var continueButtonOutler: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    private lazy var viewModel = OnboardingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }

    @IBAction func continueButton(_ sender: Any) {
        
    }
    
}

extension OnboardingViewController: OnboardingViewInterface2 {
    
    func prepareView() {
        titleLabel.text = "Quick Find Station"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        continueButtonOutler.setTitle("Continue-1", for: .normal)
        
    }
}
