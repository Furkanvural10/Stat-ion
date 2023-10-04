
import UIKit
import FirebaseFirestore

protocol NearestStationViewInterface: AnyObject {
    func configurationView()
    func zipTwoArray()
}

class NearestStationVC: UIViewController {
    
    @IBOutlet weak var nearestStationPageTitle  : UINavigationBar!
    @IBOutlet weak var nearestStationTableView  : UITableView!
    
    var station                                 : [Station]?
    var distanceKM                              : [Double]?
    var nearestStation                          : [NearestStation]?
    private lazy var viewModel = NearestStationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension NearestStationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = UITableViewCell()
        var content  = cell.defaultContentConfiguration()
        content.text = "\(nearestStation![indexPath.row].stationName) (\(nearestStation![indexPath.row].distance) \(Text.km))"
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return station!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Maps.openMapFromNearestVC(station: nearestStation![indexPath.row])
    }
}

extension NearestStationVC: NearestStationViewInterface {
    
    func configurationView() {
        nearestStationTableView.delegate        = self
        nearestStationTableView.dataSource      = self
        nearestStationPageTitle.topItem?.title  = Text.nearStationPageTitle
    }
    
    func zipTwoArray() {
        
        self.nearestStation = zip(station!, distanceKM!).map { station, distance in
            return NearestStation(
                stationName : station.stationName,
                stationType : station.stationType,
                soket1      : station.soket1,
                soket2      : station.soket2,
                geopoint    : station.geopoint,
                distance    : distance
            )
        }
        
        self.nearestStation = self.nearestStation!.sorted {
            $0.distance < $1.distance
        }
    }
    
}




