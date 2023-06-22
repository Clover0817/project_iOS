//
//  ViewController.swift
//  HelloWorld
//
//  Created by CSMAC08 on 2023/06/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var txtName: UITextField!
    @IBOutlet var lblHello: UILabel! //:UILabel 타입, 느낌표는 null 처리 관련
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSend(_ sender: UIButton) {
        lblHello.text = "Hello, " + txtName.text!
    }
    
    
}

