import UIKit

protocol StationDetailViewInterface: AnyObject {
    func configurationView()
}

final class StationDetailVC: UIViewController {
    
    @IBOutlet weak var navigationBar    : UINavigationBar!
    @IBOutlet weak var distanceView     : UIView!
    @IBOutlet weak var carItem          : UIBarButtonItem!
    @IBOutlet weak var stationTypeLabel : UILabel!
    @IBOutlet weak var distanceLabel    : UILabel!
    @IBOutlet weak var firstSoketLabel  : UILabel!
    @IBOutlet weak var secondSoketLabel : UILabel!
    @IBOutlet weak var firstView        : UIView!
    @IBOutlet weak var secondView       : UIView!
    @IBOutlet weak var firstImage       : UIImageView!
    @IBOutlet weak var secondImage      : UIImageView!
    @IBOutlet weak var firstSoketType   : UILabel!
    @IBOutlet weak var secondSoketType  : UILabel!
    
    var stationDetail : Station?
    var distance      : Double?
    private lazy var viewModel = StationDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    
    
    @IBAction func openMaps(_ sender: Any) {
        viewModel.openMaps(station: stationDetail!)
    }
}

extension StationDetailVC: StationDetailViewInterface {
    func configurationView() {
        
        let isSocket1Exist = stationDetail?.soket1 == "-" ? false : true
        let isSocket2Exist = stationDetail?.soket2 == "-" ? false : true
        
        self.navigationBar.topItem?.title    = stationDetail?.stationName
        self.carItem.image                   = Images.carFillImage
        self.stationTypeLabel.text           = "\(Text.stationType) \(stationDetail!.stationType)"
        self.stationTypeLabel.font           = Fonts.text14Font
        self.stationTypeLabel.alpha          = Alpha.alpha08
        
        self.distanceView.layer.cornerRadius = Radius.cornerRadius5
        self.distanceView.backgroundColor    = .systemBlue
        self.distanceLabel.text              = "\(self.distance!) \(Text.km)"
        self.distanceLabel.textColor         = .white
        self.distanceLabel.font              = Fonts.text14Font
        
        self.firstView.layer.cornerRadius    = Radius.cornerRadius10
        self.secondView.layer.cornerRadius   = Radius.cornerRadius10
        
        self.firstSoketLabel.text            = Text.soket1
        self.firstSoketLabel.font            = Fonts.text15Font
        self.firstSoketLabel.textColor       = isSocket1Exist ? .black : .white
        self.secondSoketLabel.text           = Text.soket2
        self.secondSoketLabel.font           = Fonts.text15Font
        self.secondSoketLabel.textColor      = isSocket2Exist ? .black : .white
 
        self.firstView.backgroundColor       = isSocket1Exist  ? .systemGreen : .systemGray5
        self.secondView.backgroundColor      = isSocket2Exist ? .systemGreen : .systemGray5
        let soket1                           = isSocket1Exist ? stationDetail?.soket1 : Text.notExist
        let soket2                           = isSocket2Exist ? stationDetail?.soket2 : Text.notExist
        let replaceTextSoket1                = soket1!.replacingOccurrences(of: ", ", with: "\n•")
        let replaceTextSoket2                = soket2!.replacingOccurrences(of: ", ", with: "\n•")
        self.firstSoketType.text             = "•\(replaceTextSoket1)"
        self.secondSoketType.text            = "•\(replaceTextSoket2)"
        self.firstSoketType.numberOfLines    = ValueInteger.zeroNumberOfLines
        self.secondSoketType.numberOfLines   = ValueInteger.zeroNumberOfLines
 
        self.firstSoketType.alpha            = Alpha.alpha09
        self.secondSoketType.alpha           = Alpha.alpha09
    }
}
