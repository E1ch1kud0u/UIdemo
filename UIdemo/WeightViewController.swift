//
//  WeightViewController.swift
//  UIdemo
//
//  Created by Airi Furukawa on 2022/06/17.
//

import UIKit

class WeightViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var weightLabel: UITextField!
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightLabel.delegate = self
        
        weightLabel.layer.cornerRadius = 10
        weightLabel.keyboardType = .decimalPad
        
        weightLabel.text = userDefault.string(forKey: "userWeight")
    }
    
    @IBAction func saveW(_ sender: Any) {
        userDefault.set(weightLabel.text, forKey: "userWeight")
    }
    
   

}
