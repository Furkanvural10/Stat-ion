//
//  StationDetailVC.swift
//  Stat-ion
//
//  Created by furkan vural on 3.04.2023.
//

import UIKit

class StationDetailVC: UIViewController {
    
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var carItem: UIBarButtonItem!
    @IBOutlet weak var stationTypeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var firstSoketLabel: UILabel!
    @IBOutlet weak var secondSoketLabel: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var firstSoketType: UILabel!
    @IBOutlet weak var secondSoketType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
