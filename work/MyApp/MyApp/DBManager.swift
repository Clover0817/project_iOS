//
//  DBManager.swift
//  MyApp
//
//  Created by cs_mac on 2020/07/22.
//  Copyright © 2020 cs_mac. All rights reserved.
//

import Foundation
import SQLite3

class DBManager {
    let DB_NAME = "my_db.sqlite"
    let TABLE_NAME = "my_table"
    let COL_ID = "id"
    let COL_TITLE = "title"
    let COL_DATE = "date"
    let COL_DETAIL = "detail"
    let COL_ICON = "icon"
    
    var db : OpaquePointer?
    
//    앱을 실행할 때 수행
    func initDatabase() {
        openDatabase()
        createTable()
        closeDatabase()
    }
    
//    DB 사용 전에 호출
    private func openDatabase() {
        let dbFile = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(DB_NAME)
        
        if sqlite3_open(dbFile.path, &db) == SQLITE_OK {
            print("Successfully Opened")
            print(dbFile)
        } else {
            print("Unable to open DB")
        }
    }
    
//    테이블 생성
    private func createTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS \(TABLE_NAME) ( \(COL_ID) INTEGER PRIMARY KEY AUTOINCREMENT, \(COL_TITLE) TEXT, \(COL_DATE) INT32, \(COL_DETAIL) TEXT, \(COL_ICON) TEXT);
            """
        
        var createTableStmt: OpaquePointer?
        
        print("TABLE SQL: \(createTableString)")
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStmt, nil) == SQLITE_OK {
            if sqlite3_step(createTableStmt) == SQLITE_DONE {
                print("Successfully created. ")
            }
            sqlite3_finalize(createTableStmt)
        } else {
            let error = String(cString: sqlite3_errmsg(db)!)
            print("Table Error: \(error)")
        }
    }
    
//    DB 완료 후 호출 
    private func closeDatabase() {
        if sqlite3_close(db) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Database Close Error: \(errmsg)")
            return
        } else {
            print("Successfully Closed. ")
        }
    }
    
//    items 배열에 DB의 내용 전체를 추가
    func readAllData() {
        let sql = "select * from \(TABLE_NAME)"
        
        var queryResult: OpaquePointer?
        
        if sqlite3_prepare(db, sql, -1, &queryResult, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Reading Error: \(errmsg)")
            return
        }
        
        while (sqlite3_step(queryResult) == SQLITE_ROW) {
            let id = sqlite3_column_int(queryResult, 0)
            let title = String(cString: sqlite3_column_text(queryResult, 1))
            let date = sqlite3_column_int(queryResult, 2)
            let detail = String(cString: sqlite3_column_text(queryResult, 3))
            let icon = String(cString: sqlite3_column_text(queryResult, 4))
            
            items.append(TaskDto(id: Int(id), title: title, date: date, detail: detail, icon: icon))
        }
        
////        샘플이므로 DB 구현 시 주석 처리
//        items.append(TaskDto(id: 1, title: "hello", date: 1595415833, detail: "hi", icon: "clock.png"))
//        items.append(TaskDto(id: 2, title: "안녕하세요", date: 1595415833, detail: "안녕", icon: "cart.png"))
    }
    
//    항목 추가
    func insert(title: String, date: Int32, detail: String, icon: String) {
        let sql = "insert into \(TABLE_NAME) values (null, ?, ?, ?, ?)"
        var insertStmt: OpaquePointer?
        
        if sqlite3_prepare_v2(db, sql, -1, &insertStmt, nil) == SQLITE_OK {
            bindTextParams(insertStmt!, no: 1, param: title)
            bindIntParams(insertStmt!, no: 2, param: Int(date))
            bindTextParams(insertStmt!, no: 3, param: detail)
            bindTextParams(insertStmt!, no: 4, param: icon)
            
            if sqlite3_step(insertStmt) == SQLITE_DONE {
                print("Successfully inserted. ")
            } else {
                print("insert error")
            }
            
            sqlite3_finalize(insertStmt)
        } else {
            print("Insert statement is not prepared. ")
        }
    }
    
//    항목 수정
    func update(title: String, date: Int32, detail: String) {
        let query = "update \(TABLE_NAME) set \(COL_TITLE) = ?, \(COL_DATE) = ? \(COL_DETAIL) = ? where \(COL_ID) = ?"
        
        var updateStmt: OpaquePointer?
        
        if sqlite3_prepare(db, query, -1, &updateStmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing update: \(errmsg)")
            return
        }
        
        bindTextParams(updateStmt!, no: 1, param: title)
        bindIntParams(updateStmt!, no: 2, param: Int(date))
        bindTextParams(updateStmt!, no: 3, param: detail)
        
        sqlite3_finalize(updateStmt)
    }
    
//    항목 삭제
    func delete(_ id: Int) {
        let query = "delete from \(TABLE_NAME) where \(COL_ID) = ?"
        var deleteStmt: OpaquePointer?
        
        if sqlite3_prepare(db, query, -1, &deleteStmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing stmt: \(errmsg)")
            return
        }
        
        bindIntParams(deleteStmt!, no: 1, param: id) //함수화
        
        if sqlite3_step(deleteStmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Delete Failure: \(errmsg)")
            return
        }
        
        sqlite3_finalize(deleteStmt)
    }
    
    func bindTextParams(_ stmt: OpaquePointer, no: Int, param: String) {
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        if sqlite3_bind_text(stmt, Int32(no), param, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Text Binding Failure: \(errmsg)")
            return
        }
    }
    
    func bindIntParams(_ stmt: OpaquePointer, no: Int, param: Int) {
        if sqlite3_bind_int(stmt, Int32(no), Int32(param)) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Integer Binding Failure: \(errmsg)")
            return
        }
    }
}
