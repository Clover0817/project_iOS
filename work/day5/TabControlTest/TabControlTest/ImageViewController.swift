//
//  ViewController.swift
//  imageViewtest
//
//  Created by CSMAC08 on 2023/06/23.
//
var no : Int = 1
let name = String(no) + ".png"
import UIKit

class ImageViewController: UIViewController {
    
    var isZoom = false;
    var imgOn: UIImage? //물음표: 값의 존재여부를 알 수 없을 때 기록 = nil(=null) = 래핑
    var imgOff: UIImage?
    
    @IBOutlet var imgView: UIImageView! //언래핑

    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        
        imgView.image = imgOn
    }
    
    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        
        if (isZoom) {
            newWidth = imgView.frame.width / scale
            newHeight = imgView.frame.height / scale
            
            btnResize.setTitle("확대", for: .normal)
        }else {
            newWidth = imgView.frame.width * scale
            newHeight = imgView.frame.height * scale
            
            btnResize.setTitle("축소", for: .normal)
        }
        
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        isZoom = !isZoom
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn { //if 조건문 괄호 생략 가능
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
    }
    
}

