//
//  SettingsViewController.swift
//  UIdemo
//
//  Created by Airi Furukawa on 2022/06/17.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var weightBtn: UIButton!
    @IBOutlet weak var DoBBtn: UIButton!
    @IBOutlet weak var DailyBtn: UIButton!
    //@IBOutlet weak var CorFBtn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weightBtn.layer.cornerRadius = 10
        DoBBtn.layer.cornerRadius = 10
        DailyBtn.layer.cornerRadius = 10
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
