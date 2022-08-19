//
//  DataViewController.swift
//  UIdemo
//
//  Created by Airi Furukawa on 2022/06/17.
//

import UIKit

class DataViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var tempField: UITextField!
    @IBOutlet weak var stepField: UITextField!
  //  @IBOutlet weak var saveBtn: UIButton!
    let userDefaults = UserDefaults.standard
    var changeDate : Date = Date()
    let today: Date = Date()
    let dateFormatter = DateFormatter()
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()

        tempField.layer.cornerRadius = 10
        tempField.clipsToBounds = true
        tempField.delegate = self
        stepField.layer.cornerRadius = 10
        stepField.clipsToBounds = true
        stepField.delegate = self
        
       // saveMemory(UIButton).layer.cornerRadius = 10
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if changeDate == today {
            datePickerButton.setTitle(dateFormatter.string(from: today), for: .normal)
        } else {
            datePickerButton.setTitle(dateFormatter.string(from: changeDate), for: .normal)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func saveMemory(_ sender: UIButton) {
        performSegue(withIdentifier: "saveMemory", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //Empty input values will generate an error.
            if segue.identifier == "saveMemory" {
                let nextView = segue.destination as! GraphViewController
                //If empty, nothing is done and transition to the results screen
                if tempField.text! != "" || stepField.text! != "" {
                    nextView.tempText = Double(tempField.text!)!
                    nextView.exerText = Double(stepField.text!)!
                    nextView.dateText = datePickerButton.titleLabel!.text!
                }
            }
        }
}

