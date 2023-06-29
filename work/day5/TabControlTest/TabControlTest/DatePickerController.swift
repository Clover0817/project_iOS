//
//  ViewController.swift
//  datePickerTest
//
//  Created by CSMAC08 on 2023/06/23.
//

import UIKit

class DatePickerController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime) //selector로 포장됨
    let interval = 1.0
    var count = 0
    
    var str1 = ""
    var str2 = ""
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    @IBOutlet var lblCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true) //interval = timer 도는 주기, selector=timer가 수행할 동작

    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblPickerTime.text = "선택시간: " + formatter.string(from: datePickerView.date)
        
        str1 = formatter.string(from: datePickerView.date)
    }
    
    @objc func updateTime() {
        lblCount.text = String(count)
        count = count + 1
        
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간: " + formatter.string(from: date as Date) //as는 type casting
        
        str2 = formatter.string(from: date as Date)
        if (str1 == str2) { // 타이머 시간 되면 화면 빨간색으로 변경
            view.backgroundColor = UIColor.red
        }
        if (count / 100 == 0) {
            view.backgroundColor = UIColor.purple
        }
    }
    
}

