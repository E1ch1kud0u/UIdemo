//
//  ViewController.swift
//  UIdemo
//
//  Created by Airi Furukawa on 2022/06/17.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var messageView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //round corner
        messageView.layer.cornerRadius = 10
        //shadow
        messageView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        messageView.layer.shadowColor = UIColor.black.cgColor
        messageView.layer.shadowOpacity = 0.6
        messageView.layer.shadowRadius = 4
        
        messageView.font = UIFont.boldSystemFont(ofSize: 20)
        
        let randomInt = Int.random(in: 1..<5)
        
        switch randomInt {
        case 1:
            messageView.text = "I'm sorry you're going through this, I hope it goes quickly."
        case 2:
            messageView.text = "Did you exercise today?"
        case 3:
            messageView.text = "Eat healthy, get less pain."
        default:
            messageView.text = "Good morning!"
        }
    }


}

