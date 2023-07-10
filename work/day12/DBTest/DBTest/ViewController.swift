//
//  ViewController.swift
//  DBTest
//
//  Created by CSMAC08 on 2023/07/10.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    let DB_NAME = "my_db.sqlite"
    let TABLE_NAME = "my_table"
    let COL_ID = "id"
    let COL_NAME = "name"
    
    var db: OpaquePointer? = nil
    var manager: DBManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = DBManager()
    }
    
    @IBAction func btnOpenDatabase(_ sender: UIButton) {
        manager.openDatabase()
    }
    
    @IBAction func btnCreateTable(_ sender: UIButton) {
        manager.createTable()
    }
    
    @IBAction func btnInsert(_ sender: UIButton) {
        manager.insert()
    }
    
    @IBAction func btnSelectAll(_ sender: UIButton) {
        manager.select()
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        manager.update()
     }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        manager.delete()
    }
    
    @IBAction func btnDropTable(_ sender: UIButton) {
        manager.dropTable()
    }
    
    @IBAction func btnCloseDatabase(_ sender: UIButton) {
        manager.close()
    }
}
