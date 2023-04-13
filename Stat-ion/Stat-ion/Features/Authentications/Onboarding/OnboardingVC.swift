import UIKit
import MapKit
import CoreLocation


class OnboardingVC: UIViewController {

    @IBOutlet weak var onboardingImageView  : UIImageView!
    @IBOutlet weak var mainView             : UIView!
    @IBOutlet weak var firstLabel           : UILabel!
    @IBOutlet weak var secondLabel          : UILabel!
    @IBOutlet weak var thirdLabel           : UILabel!
    @IBOutlet weak var mapView              : MKMapView!
    @IBOutlet weak var startButton          : UIButton!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        checkOnboardingPageSeen()
        configureOnboardingView()
        configureMapView()
    }
    
    func startAnimation(){
        self.onboardingImageView.alpha = Alpha.alpha0
        self.mainView.alpha            = Alpha.alpha0
        UIView.animate(withDuration: 1, delay: 0) {
            self.onboardingImageView.alpha = Alpha.alpha
            self.mainView.alpha            = Alpha.alpha
        }
    }
    
     func checkOnboardingPageSeen(){
         let result = UserDefaults.standard.object(forKey: Text.onboardingSeen)
         if (result as? Bool) != nil {
             self.performSegue(withIdentifier: Text.toChargeStationMapVC, sender: nil)
         }
    }
    
    fileprivate func labelConfig(_ labelColor: UIColor, _ fontSize: CGFloat) {
        //MARK: - Labels Config
        self.firstLabel.textColor                       = labelColor
        self.firstLabel.font                            = .boldSystemFont(ofSize: fontSize)
        self.firstLabel.text                            = Text.onboardingFirstLabel
        self.firstLabel.adjustsFontSizeToFitWidth       = true
        self.secondLabel.textColor                      = labelColor
        self.secondLabel.font                           = .boldSystemFont(ofSize: fontSize)
        self.secondLabel.text                           = Text.onboardingSecondLabel
        self.secondLabel.adjustsFontSizeToFitWidth      = true
        self.thirdLabel.textColor                       = labelColor
        self.thirdLabel.font                            = .boldSystemFont(ofSize: fontSize)
        self.thirdLabel.adjustsFontSizeToFitWidth       = true
        self.thirdLabel.text                            = Text.onbardingThirdLabel
    }
    fileprivate func mapViewConfig(_ cornerRadius: CGFloat) {
        //MARK: - MapView Config
        self.mapView.layer.cornerRadius = cornerRadius
        self.mapView.isRotateEnabled    = false
        self.mapView.isZoomEnabled      = false
        self.mapView.isScrollEnabled    = false
        self.mapView.showsUserLocation  = true
    }
    fileprivate func imageViewConfig() {
        //MARK: - ImageView Config
        self.onboardingImageView.image       = Images.onboarding
        self.onboardingImageView.contentMode = .scaleToFill
        let overlay                          = UIView(frame: onboardingImageView.bounds)
        overlay.backgroundColor              = UIColor.black
        overlay.alpha                        = Alpha.alpha04
        
        onboardingImageView.addSubview(overlay)
    }
    fileprivate func startButtonConfig() {
        //MARK: - StartButton Config
        self.startButton.tintColor = .black
        self.startButton.setTitle(Text.startOnboardingTitle, for: .normal)
    }
    
    private func configureOnboardingView(){
        let cornerRadius: CGFloat = Radius.cornerRadius20
        let fontSize: CGFloat     = Radius.cornerRadius25
        let labelColor: UIColor   = .white
        
        imageViewConfig()
        mapViewConfig(cornerRadius)
        labelConfig(labelColor, fontSize)
        startButtonConfig()
        
        //MARK: - View Config
        self.mainView.layer.cornerRadius = cornerRadius
    
    }
    private func configureMapView(){
        self.locationManager.delegate   = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func upMovedLabelTransformLabel() {
        self.firstLabel.alpha      = Alpha.alpha0
        self.firstLabel.transform  = CGAffineTransform(translationX: 0, y: -100)
        self.secondLabel.alpha     = Alpha.alpha0
        self.secondLabel.transform = CGAffineTransform(translationX: 0, y: -100)
        self.thirdLabel.alpha      = Alpha.alpha0
        self.thirdLabel.transform  = CGAffineTransform(translationX: 0, y: -100)
    }
    fileprivate func leftMovedTransformLabel() {
        self.firstLabel.transform  = CGAffineTransform(translationX: -10, y: 0)
        self.secondLabel.transform = CGAffineTransform(translationX: -10, y: 0)
        self.thirdLabel.transform  = CGAffineTransform(translationX: -10, y: 0)
    }
    fileprivate func upMovedMapAndButton() {
        self.mapView.alpha         = Alpha.alpha0
        self.startButton.alpha     = Alpha.alpha0
        self.mapView.transform     = CGAffineTransform(translationX: 0, y: 100)
        self.startButton.transform = CGAffineTransform(translationX: 0, y: 100)
    }
    fileprivate func leftMovedTransformMapAndLabel() {
        self.mapView.transform     = CGAffineTransform(translationX: 10, y: 0)
        self.startButton.transform = CGAffineTransform(translationX: 10, y: 0)
    }
    
    fileprivate func animation() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity: 6, options: .curveEaseOut) {
            self.leftMovedTransformLabel()
            self.leftMovedTransformMapAndLabel()
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity: 6, options: .curveEaseOut) {
                self.upMovedLabelTransformLabel()
                self.upMovedMapAndButton()
                self.onboardingImageView.alpha = Alpha.alpha0
            } completion: { _ in
                self.performSegue(withIdentifier: Text.toChargeStationMapVC, sender: nil)
            }
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        animation()
        UserDefaults.standard.set(true, forKey: Text.onboardingSeen)
    }
}

extension OnboardingVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude            = locations[0].coordinate.latitude
        let longitude           = locations[0].coordinate.longitude
        let spanLatitudeDelta   = ValueInteger.zoomLatitudeDelta
        let spanLongitudeDelta  = ValueInteger.zoomLongitudeDelta
        let location            = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span                = MKCoordinateSpan(latitudeDelta: spanLatitudeDelta, longitudeDelta: spanLongitudeDelta)
        let region              = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
}

