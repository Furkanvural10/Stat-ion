//
//  Stat-ion
//
//  Created by furkan vural on 5.10.2023.
//

import UIKit
import Lottie

protocol OnboardingViewInterface: AnyObject, SeguePerformable {
    
    var slides: [Slide] { get }
    
    func prepareOnboardingView()
    func endingOnboardingPage()
    func handleActionButtonTapped(at indexPath: IndexPath, nextIndexPath: IndexPath, nextItem: Int)
    
}

final class OnboardingViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageController: UIPageControl!
    
    
    private lazy var viewModel = OnboardingViewModel()
    let slides: [Slide] = Slide.collection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
        
    }
    
    private func checkOnboardingPageSeen() {
        viewModel.checkOnboardingPageSeen()
    }
    
    private func setupPageControl() {
        pageController.numberOfPages = slides.count
        
    }
    
    private func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        
        
    }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = index
    }

}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! OnboardingCollectionViewCell
        let slide = slides[indexPath.item]
        cell.configure(with: slide)
        cell.actionButtonDidTapped = { [weak self] in
            self?.viewModel.handleActionButtonTapped(at: indexPath)
        }
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

extension OnboardingViewController: OnboardingViewInterface {
    func handleActionButtonTapped(at indexPath: IndexPath, nextIndexPath: IndexPath, nextItem: Int) {
        self.collectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
        self.pageController.currentPage = nextItem
        
    }
    
    func endingOnboardingPage() {
        viewModel.endingOnboardingPage()
    }
    
    func prepareOnboardingView() {
        checkOnboardingPageSeen()
        setupCollectionView()
        setupPageControl()
    }
    

}


