//
//  ExerciseViewController.swift
//  UIdemo
//
//  Created by Airi Furukawa on 2022/06/17.
//

import UIKit

class ExerciseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ExText.text = list[row]
    }

    @IBOutlet weak var ExText: UITextField!
    let userDefaults = UserDefaults.standard
    var pickerView = UIPickerView()
    var list = ["Professional", "Hobby", "Moderate", "Mature", "Not at all"]

    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        ExText.text = userDefaults.string(forKey: "userEx")
    }
    func createPickerView() {
        pickerView.delegate = self
        ExText.inputView = pickerView
        // toolbar
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ExerciseViewController.donePicker))
        toolbar.setItems([doneButtonItem], animated: true)
        ExText.inputAccessoryView = toolbar
    }
    @objc func donePicker() {
        ExText.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ExText.endEditing(true)
    }
    @IBAction func saveD() {
        userDefaults.set(ExText.text, forKey: "userEx")
    }
}
