//
//  DateViewController.swift
//  UIdemo
//
//  Created by Airi Furukawa on 2022/06/17.
//

import UIKit

class DateViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dobText: UITextField!
    let userDefaults = UserDefaults.standard
    var datePicker = UIDatePicker()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spaceItem, doneItem], animated: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        datePicker.date = formatter.date(from: "2000 01 01")!
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        dobText.inputView = datePicker
        dobText.inputAccessoryView = toolbar
        dobText.text = userDefaults.string(forKey: "userDoB")
        
    }
    
    @objc func done() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        dobText.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func saveD() {
        userDefaults.set(dobText.text, forKey: "userDoB")
    }
}
