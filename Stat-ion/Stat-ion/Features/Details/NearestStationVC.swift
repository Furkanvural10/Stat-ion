
import UIKit
import FirebaseFirestore

class NearestStationVC: UIViewController {
    
    
    @IBOutlet weak var nearestStationPageTitle: UINavigationBar!
    @IBOutlet weak var nearestStationTableView: UITableView!
    var station: [Station]?
    var distanceKM: [Double]?
    var nearestStation: [NearestStation]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
        zipTwoArray()
    }
    
    private func configurationView(){
        nearestStationTableView.delegate = self
        nearestStationTableView.dataSource = self
        nearestStationPageTitle.topItem?.title = "En Yakın İstasyonlar"
    }
    
    private func zipTwoArray(){
        self.nearestStation = zip(station!, distanceKM!).map { station, distance in
            return NearestStation(
                stationName: station.stationName,
                stationType: station.stationType,
                soket1: station.soket1,
                soket2: station.soket2,
                geopoint: station.geopoint,
                distance: distance
            )
        }
        self.nearestStation = self.nearestStation!.sorted {
            $0.distance < $1.distance
        }
        
    }

}

extension NearestStationVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = "\(nearestStation![indexPath.row].stationName) (\(nearestStation![indexPath.row].distance) KM)"
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return station!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: - Open Navigation
        let latitude = nearestStation![indexPath.row].geopoint.latitude
        let longitude = nearestStation![indexPath.row].geopoint.longitude
        let urlString = "http://maps.apple.com/?daddr=\(latitude),\(longitude)&dirflg=d"
        if let url = URL(string: urlString){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}




