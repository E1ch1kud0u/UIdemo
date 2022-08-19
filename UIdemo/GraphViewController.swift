//
//  GraphViewController.swift
//  UIdemo
//
//  Created by Airi Furukawa on 2022/06/17.
//

import UIKit
import Charts

class GraphViewController: UIViewController, ChartViewDelegate {
    
    
    @IBOutlet weak var chartsView: LineChartView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var exerLabel: UILabel!
    let userDefaults = UserDefaults.standard
    let tempString = "Temperature"
    let exerString = "Exercise"
    
    var tempDic = [String:Double]()
    var tempList = [Double]()
    var tempText = 0.0
    
    var exerList = [Double]()
    var exerDic = [String:Double]()
    var exerText = 0.0
    
    var dateText = ""
    var daysList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartsView.delegate = self
        let tempKey = tempString + dateText
        let exerKey = exerString + dateText
        
        loadView()
        if tempKey != "Temperature" || exerKey != "Exercise" {
                    saveData(tempKey : tempKey, exerKey: exerKey, daysText:dateText)
                } else if dateText == "" {
                    let tempSort = tempDic.keys.sorted()
                    let exerSort = exerDic.keys.sorted()

                    for key in tempSort {
                        tempList.append(tempDic[key]!)
                        daysList.append(String(key.suffix(5)))
                    }
                    for key in exerSort {
                        exerList.append(exerDic[key]!)
                    }
                    setChart(days:daysList)
                }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func deleteUserDefault(_ sender: Any) {
            print("Clear")
            let alert: UIAlertController = UIAlertController(title: "Delete Data", message: "Would you like to erase all the data？", preferredStyle: UIAlertController.Style.actionSheet)
            let comit = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                    (action: UIAlertAction!) -> Void in
                self.userDefaults.removeObject(forKey: "temp")
                self.userDefaults.removeObject(forKey: "exer")
                self.daysList = [""]
                self.tempList = [Double]()
                self.exerList = [Double]()
                self.dateLabel.text! = ""
                self.tempLabel.text! = ""
                self.exerLabel.text! = ""
                self.setChart(days: self.daysList)
                super.viewDidLoad()
            })
            let cancel = UIAlertAction(title: "Return", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(comit)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    
    //enter data into DIctionary from userDefaults
    //do nothing if no data(1st time and after delete)
    func loadData() {
        if userDefaults.dictionary(forKey: "temp") != nil {
            tempDic = userDefaults.dictionary(forKey: "temp") as! [String : Double]
        }
        if userDefaults.dictionary(forKey: "exer") != nil {
            exerDic = userDefaults.dictionary(forKey: "exer") as! [String : Double]
        }
    }
    //渡ってきた値をuserDefaultsへセットし、リストへDictionaryのValueをset
    func saveData(tempKey : String,exerKey : String, daysText: String) {
            tempDic[tempKey] = tempText
            exerDic[exerKey] = exerText

            userDefaults.set(tempDic, forKey: "temp")
            userDefaults.set(exerDic, forKey: "exer")
            userDefaults.synchronize()

            let tempSort = tempDic.keys.sorted()
            let exerSort = exerDic.keys.sorted()

            for key in tempSort {
                exerList.append(tempDic[key]!)
                daysList.append(String(key.suffix(5)))
            }
            for key in exerSort {
                exerList.append(exerDic[key]!)
            }
            setChart(days:daysList)
        }
    func setChart(days:[String]){
        let lineDefault = UIColor(red: 140.0/255.0, green: 234.0/255.0, blue: 255.0/255.0, alpha: 1.0)

        let data = LineChartData()
        var lineChartEntry1 = [ChartDataEntry]()

        for i in 0..<tempList.count {
            lineChartEntry1.append(ChartDataEntry(x: Double(i), y: Double(tempList[i])))
        }
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "Temperature")
        line1.drawCirclesEnabled = false
        line1.drawValuesEnabled = true
        line1.valueTextColor = UIColor.white
        line1.lineWidth = 2
        line1.setColor(UIColor.red)
        data.append(line1)

        if (exerList.count > 0) {
            var lineChartEntry2 = [ChartDataEntry]()
            for i in 0..<exerList.count {
                lineChartEntry2.append(ChartDataEntry(x: Double(i), y: Double(exerList[i])))
            }
            let line2 = LineChartDataSet(entries: lineChartEntry2, label: "Exercise")
            line2.drawCirclesEnabled = false
            line2.drawValuesEnabled = true
            line2.valueTextColor = UIColor.white
            line2.lineWidth = 2
            line2.setColor(UIColor.blue)
            data.append(line2)
            }
            let chartFormatter = LineChartFormatter(labels: days)
            let xAxis = chartsView.xAxis
            xAxis.valueFormatter = chartFormatter
            xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 12.0)!
            xAxis.labelTextColor = UIColor.white
            chartsView.xAxis.granularityEnabled = true
            chartsView.xAxis.granularity = 1.0
            chartsView.xAxis.decimals = 0
            chartsView.xAxis.valueFormatter = xAxis.valueFormatter
            chartsView.data = data
        }
    private class LineChartFormatter: NSObject, AxisValueFormatter {

            var labels: [String] = []

            func stringForValue(_ value: Double, axis: AxisBase?) -> String {
                if labels.count == 1 {
                    return labels[0]
                } else {
                    return labels[Int(value)]
                }
            }
            init(labels: [String]) {
                super.init()
                self.labels = labels
            }
        }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let tempSort = tempDic.keys.sorted()
            let exerSort = exerDic.keys.sorted()
            var tempKey :String
            var exerKey : String
            var dateString : String

            if highlight.dataSetIndex == 0 {
                tempKey  = tempSort[NSInteger(entry.x)]
                exerKey = "Exercise" + tempSort[NSInteger(entry.x)].suffix(10)
                dateString = String(tempSort[NSInteger(entry.x)].suffix(10))
            } else {
                tempKey  = "Temperature" + exerSort[NSInteger(entry.x)].suffix(10)
                exerKey = exerSort[NSInteger(entry.x)]
                dateString = String(exerSort[NSInteger(entry.x)].suffix(10))
            }
            let tempString = tempDic[tempKey]
            let exerString = exerDic[exerKey]

            dateLabel.text = dateString
            dateLabel.textColor = UIColor.white
            tempLabel.text = String(tempString!) + "K"
            tempLabel.textColor = UIColor.white
            exerLabel.text = String(exerString!) + "Steps"
            exerLabel.textColor = UIColor.white
        }
}
