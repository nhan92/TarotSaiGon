//
//  DatabaseManager.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 4/21/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DatabaseManager
{
    var database:COpaquePointer!;

    func confirgureDatabaseWithName(fullDBName:String)
    {
        if let temp = database
        {
            // Close
            sqlite3_close(database);
            
            // Init
            database = NhanNguyen_Connect_DB_Sqlite(fullDBName)
            
        }
        else
        {
            // Init
            database = NhanNguyen_Connect_DB_Sqlite(fullDBName)
        }
    }
    
    func getAllOfTarotCaseInDatabase() -> [TarotCard]
    {
        var arrCard:[TarotCard] = []
        
        var statement:COpaquePointer = NhanNguyen_Select("SELECT * FROM tarot_viet", database: database);
        
        
        while sqlite3_step(statement) == SQLITE_ROW
        {
            let row = Int(sqlite3_column_int(statement, 0))
            let rowData = sqlite3_column_text(statement, 1)
            let nameCard = String.fromCString(UnsafePointer<CChar>(rowData))
            
            let rowData1 = sqlite3_column_text(statement, 3)
            let keyWord = String.fromCString(UnsafePointer<CChar>(rowData1))
            
            let rowData2 = sqlite3_column_text(statement, 2)
            let forwardCard = String.fromCString(UnsafePointer<CChar>(rowData2))
            
            let rowData3 = sqlite3_column_text(statement, 9)
            let reverseCard = String.fromCString(UnsafePointer<CChar>(rowData3))
            
            let rowData4 = sqlite3_column_text(statement, 4)
            let images = String.fromCString(UnsafePointer<CChar>(rowData4))
            
            let rowData5 = sqlite3_column_text(statement, 5)
            let keyDetail = String.fromCString(UnsafePointer<CChar>(rowData5))
            
            let rowData6 = sqlite3_column_text(statement, 8)
            let information = String.fromCString(UnsafePointer<CChar>(rowData6))
            
            let rowData7 = sqlite3_column_text(statement, 6)
            let cardAntonyms = String.fromCString(UnsafePointer<CChar>(rowData7))
            
            let rowData8 = sqlite3_column_text(statement, 7)
            let cardSynonyms = String.fromCString(UnsafePointer<CChar>(rowData8))
            
            let newcard:TarotCard = TarotCard(nameCard: nameCard!, keyWord: keyWord!, keyDetail: keyDetail!, images: images!, cardAntonyms: cardAntonyms!, cardSynonyms: cardSynonyms!, information: information!, forwardCard: forwardCard!, reverseCard: reverseCard!, idCard: row)
            
            arrCard.append(newcard);
            
        }
        
        sqlite3_finalize(statement)
        
        
        return arrCard
    }
    
    
    func NhanNguyen_Select(var query:String,  var database:COpaquePointer)->COpaquePointer{
        var statement:COpaquePointer = nil
        sqlite3_prepare_v2(database, query, -1, &statement, nil)
        return statement
    }
    
    
    func NhanNguyen_Query(var sql:String, var database:COpaquePointer){
        var errMsg:UnsafeMutablePointer<Int8> = nil
        var result = sqlite3_exec(database, sql, nil, nil, &errMsg);
        if (result != SQLITE_OK) {
            sqlite3_close(database)
            println("Cau truy van bi loi!")
            return
        }
    }
    
    
    func NhanNguyen_Connect_DB_Sqlite(var fullDBName:String)->COpaquePointer
    {
        var database:COpaquePointer = nil
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        
        let storePath : String = documentsPath.stringByAppendingPathComponent(fullDBName)
        
        var result = sqlite3_open(storePath, &database)
        if result != SQLITE_OK {
            sqlite3_close(database)
            println("Failed to open database")
        }
        return database

    }
    

    
}
