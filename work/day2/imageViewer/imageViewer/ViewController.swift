//
//  ViewController.swift
//  imageViewtest
//
//  Created by CSMAC08 on 2023/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    var img: UIImage?
    var no : Int = 1
    
    @IBOutlet var imgView: UIImageView! //언래핑

    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var btnFront: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img = UIImage(named: "1.png")
        
        imgView.image = img
    }
    
    @IBAction func viewNextImg(_ sender: UIButton) {
        no += 1
        
        if (no < 7) {
            img = UIImage(named: String(no) + ".png")
            imgView.image = img
        } else {
            no = 1
        }
    }
    @IBAction func viewBeforeImg(_ sender: UIButton) {
        no -= 1
        
        if (no > 0) {
            img = UIImage(named: String(no) + ".png")
            imgView.image = img
        } else {
            no = 6
        }
    }
    
}

