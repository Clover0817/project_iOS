//
//  ViewController.swift
//  MyApp
//
//  Created by cs_mac on 2020/07/22.
//  Copyright © 2020 cs_mac. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var dpPicker: UIDatePicker!
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfDetail: UITextField!
    @IBOutlet var imagePicker: UIPickerView!
    
    var taskTitle: String!
    var pickDate: Int32!
    var detail: String!
    var icon: String!
    
    var img = ""
    let MAX_ARRAY_NUM = 3
    let PICKER_VIEW_COLUMN = 1
    let PICKER_VIEW_HEIGHT:CGFloat = 150
    var imageArray = [UIImage?]()
    var imageFileName = ["clock.png", "pencil.png", "cart.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // DatePicker 에 현재 시간 설정
        let date = NSDate()
        dpPicker.setDate(date as Date, animated: true)
        
        let today = Int32(dpPicker.date.timeIntervalSince1970)
        print("today int: \(today)")
        
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
    }

    @IBAction func btnSave(_ sender: UIButton) {
        dpPicker.setDate(dpPicker.date as Date, animated: true)
        
        taskTitle = tfTitle.text
        pickDate = Int32(dpPicker.date.timeIntervalSince1970)
        detail = tfDetail.text
        icon = img
        
        // 뷰에 입력한 값을 사용하여 DB에 추가
        manager.insert(title: taskTitle, date: pickDate, detail: detail, icon: icon)
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        img = imageFileName[row]
    }

}

