//
//  RDTaskListCustomCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/1.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class RDTaskListCustomCell: UITableViewCell {
    @IBOutlet weak var taskStatusView: UIView!
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var clientNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskStatusView.layer.cornerRadius = 6
        backGroundView.layer.cornerRadius = 6
        clientNameLabel.textColor = .blue  //客戶名稱變藍色
        
    }
    
    
    func configureCell(rdTask:RDTaskInfo) {
       
        clientNameLabel.text = rdTask.client //顯示客戶名
        taskLabel.text = rdTask.taskTxt      //顯示任務
        let timestap = rdTask.timestamp      //顯示時間
        
        
        let date = timestap.dateValue()  //時間格式化
        let formatter = DateFormatter()  //時間格式
        formatter.dateFormat = "yyyy/M/d"
        dateLabel.text = formatter.string(from: date)  //顯示時間
        
        
        
        
    }


    
}
