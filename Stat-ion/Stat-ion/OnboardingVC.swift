import UIKit
import MapKit
import CoreLocation


class OnboardingVC: UIViewController {

    @IBOutlet weak var onboardingImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startButton: UIButton!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkOnboardingPageSeen()
        configureOnboardingView()
        configureMapView()
    }
    
     func checkOnboardingPageSeen(){
        
         let result = UserDefaults.standard.object(forKey: "onboardingSeen")
         if (result as? Bool) != nil {
             self.performSegue(withIdentifier: "toChargeStationMapVC", sender: nil)
         }
    }
    
    fileprivate func labelConfig(_ labelColor: UIColor, _ fontSize: CGFloat, _ temporaryText: String) {
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
    }
    fileprivate func mapViewConfig(_ cornerRadius: CGFloat) {
        //MARK: - MapView Config
        self.mapView.layer.cornerRadius = cornerRadius
        self.mapView.isRotateEnabled = false
        self.mapView.isZoomEnabled = false
        self.mapView.isScrollEnabled = false
        self.mapView.showsUserLocation = true
    }
    fileprivate func imageViewConfig() {
        //MARK: - ImageView Config
        self.onboardingImageView.image = UIImage(named: "Onboarding")
        self.onboardingImageView.contentMode = .scaleToFill
        let overlay = UIView(frame: onboardingImageView.bounds)
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.4
        onboardingImageView.addSubview(overlay)
    }
    fileprivate func startButtonConfig() {
        //MARK: - StartButton Config
        self.startButton.tintColor = .black
        self.startButton.setTitle("Başla", for: .normal)
    }
    
    private func configureOnboardingView(){
        let cornerRadius: CGFloat = 20
        let fontSize: CGFloat = 25
        let labelColor: UIColor = .white
        let temporaryText = "Lorem Ipsum Der Ao"
        
        imageViewConfig()
        mapViewConfig(cornerRadius)
        labelConfig(labelColor, fontSize, temporaryText)
        startButtonConfig()
        
        
        //MARK: - View Config
        self.mainView.layer.cornerRadius = cornerRadius
    
    }
    private func configureMapView(){
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func upMovedLabelTransformLabel() {
        self.firstLabel.alpha = 0
        self.firstLabel.transform = CGAffineTransform(translationX: 0, y: -100)
        self.secondLabel.alpha = 0
        self.secondLabel.transform = CGAffineTransform(translationX: 0, y: -100)
        self.thirdLabel.alpha = 0
        self.thirdLabel.transform = CGAffineTransform(translationX: 0, y: -100)
    }
    fileprivate func leftMovedTransformLabel() {
        self.firstLabel.transform = CGAffineTransform(translationX: -10, y: 0)
        self.secondLabel.transform = CGAffineTransform(translationX: -10, y: 0)
        self.thirdLabel.transform = CGAffineTransform(translationX: -10, y: 0)
    }
    fileprivate func upMovedMapAndButton() {
        self.mapView.alpha = 0
        self.startButton.alpha = 0
        self.mapView.transform = CGAffineTransform(translationX: 0, y: 100)
        self.startButton.transform = CGAffineTransform(translationX: 0, y: 100)
    }
    fileprivate func leftMovedTransformMapAndLabel() {
        self.mapView.transform = CGAffineTransform(translationX: 10, y: 0)
        self.startButton.transform = CGAffineTransform(translationX: 10, y: 0)
    }
    
    fileprivate func animation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 3, options: .curveEaseOut) {
            self.leftMovedTransformLabel()
            self.leftMovedTransformMapAndLabel()
        } completion: { _ in
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 3, options: .curveEaseOut) {
                self.upMovedLabelTransformLabel()
                self.upMovedMapAndButton()
            } completion: { _ in
                self.performSegue(withIdentifier: "toChargeStationMapVC", sender: nil)
            }
        }
    }
    fileprivate func createUser(){
        
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        createUser()
        animation()
        UserDefaults.standard.set(true, forKey: "onboardingSeen")
    }
}

extension OnboardingVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude = locations[0].coordinate.latitude
        let longitude = locations[0].coordinate.longitude
        let spanLatitudeDelta = 0.1
        let spanLongitudeDelta = 0.1
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: spanLatitudeDelta, longitudeDelta: spanLongitudeDelta)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
}

