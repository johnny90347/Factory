//
//  Model.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import Foundation

import FirebaseFirestore

//使用者資料的Ｍodel

struct UserInfo {
    
    var userName:String
    var sex:String
    var department:String
    var positionTxt:String
    var level:Int
    var createdTime:Timestamp
    
}

//研發任務的model

struct RDTaskInfo {
    var client:String       //客戶名稱
    var taskTxt:String      //研發內容
    var status:Int          //狀態
    var timestamp:Timestamp //創建時間
    var documentID:String
}

//製造任務的model

struct MDTaskInfo {
    var shipDate:Timestamp      //出貨日期
    var client:String            //客人名稱
    var productName:String       //產品名稱
    var numberOfKg:String         //幾公斤
    var device:String            //使用什麼設備做
    var status:Int               // 狀態
    var documentID:String   
}




