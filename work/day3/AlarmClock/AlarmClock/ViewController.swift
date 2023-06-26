//
//  ViewController.swift
//  AlarmClock
//
//  Created by CSMAC08 on 2023/06/26.
//  미완성

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime) //selector로 포장됨
    let interval = 1.0
    var count = 0
    
    var str1 = ""
    var str2 = ""
    @IBOutlet var presentTime: UILabel!
    @IBOutlet var selectedTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func setTime(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        selectedTime.text = formatter.string(from: datePickerView.date)
        
        str1 = formatter.string(from: datePickerView.date)
    }
    
    @objc func updateTime(_ sender: UIDatePicker) {
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        presentTime.text = formatter.string(from: date as Date)
        
        str2 = formatter.string(from: date as Date)
        if (str1 == str2) {
            let alarmAlert = UIAlertController(title: "알림", message: "설정된 시간입니다!", preferredStyle: UIAlertController.Style.alert)
        }
    }
    
    
}

