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

//研發任務的資料

struct RDTaskInfo {
    var client:String
    var taskTxt:String
    var status:Int
    var timestamp:Timestamp
    var documentID:String
}




