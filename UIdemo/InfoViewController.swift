//
//  InfoViewController.swift
//  UIdemo
//
//  Created by Airi Furukawa on 2022/06/17.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var FoodBtn: UIButton!
    @IBOutlet weak var ExerciseBtn: UIButton!
    @IBOutlet weak var GoodsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        FoodBtn.layer.cornerRadius = 10
        FoodBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        FoodBtn.layer.shadowColor = UIColor.black.cgColor
        FoodBtn.layer.shadowOpacity = 0.6
        FoodBtn.layer.shadowRadius = 4
        FoodBtn.layer.borderColor = UIColor.black.cgColor
        FoodBtn.layer.borderWidth = 1.0
        
        ExerciseBtn.layer.cornerRadius = 10
        ExerciseBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        ExerciseBtn.layer.shadowColor = UIColor.black.cgColor
        ExerciseBtn.layer.shadowOpacity = 0.6
        ExerciseBtn.layer.shadowRadius = 4
        ExerciseBtn.layer.borderColor = UIColor.black.cgColor
        ExerciseBtn.layer.borderWidth = 1.0
        
        
        GoodsBtn.layer.cornerRadius = 10
        GoodsBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        GoodsBtn.layer.shadowColor = UIColor.black.cgColor
        GoodsBtn.layer.shadowOpacity = 0.6
        GoodsBtn.layer.shadowRadius = 4
        GoodsBtn.layer.borderColor = UIColor.black.cgColor
        GoodsBtn.layer.borderWidth = 1.0
    }
    
    @IBAction func tapFood(_sender: Any){
        //遷移先の情報の取得
        let nextView = storyboard?.instantiateViewController(withIdentifier: "info3ViewController") as! info3ViewController
        nextView.modalTransitionStyle = .crossDissolve //遷移の仕方の設定
        nextView.keywords = "Food+Menstruation"
    }

    @IBAction func tapExercise(_sender: Any){
        //遷移先の情報の取得
        let nextView = storyboard?.instantiateViewController(withIdentifier: "info3ViewController") as! info3ViewController
        nextView.modalTransitionStyle = .crossDissolve //遷移の仕方の設定
        nextView.keywords = "Exercise+Menstruation"
        
    }
    
    @IBAction func tapGoods(_sender: Any){
        //遷移先の情報の取得
        let nextView = storyboard?.instantiateViewController(withIdentifier: "info3ViewController") as! info3ViewController
        nextView.modalTransitionStyle = .crossDissolve //遷移の仕方の設定
        nextView.keywords = "Goods+Menstruation"
        
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
