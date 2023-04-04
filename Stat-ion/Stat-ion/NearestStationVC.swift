//
//  NearestStationVC.swift
//  Stat-ion
//
//  Created by furkan vural on 5.04.2023.
//

import UIKit

class NearestStationVC: UIViewController {
    
    
    @IBOutlet weak var nearestStationPageTitle: UINavigationBar!
    
    @IBOutlet weak var nearestStationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configurationView()
    }
    
    private func configurationView(){
        nearestStationTableView.delegate = self
        nearestStationTableView.dataSource = self
    }
    


}

extension NearestStationVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = "Deneme"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
}
