//
//  RDTaskListCustomCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/1.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore

class RDTaskListCustomCell: UITableViewCell {
    
    var rdTask:RDTaskInfo!
    
    @IBOutlet weak var taskStatusView: UIView!
    
    @IBOutlet weak var taskStatusLabel: UILabel!
    
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var clientNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskStatusView.layer.cornerRadius = 6
        backGroundView.layer.cornerRadius = 6
        clientNameLabel.textColor = .blue  //客戶名稱變藍色
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(levelUpAndDown))

        taskStatusView.addGestureRecognizer(tap)
        taskStatusView.isUserInteractionEnabled = true
    }
    
    @objc func levelUpAndDown(){
        
          let levelNumber =  rdTask.status
        
        if levelNumber == 0 {
            Firestore.firestore().collection("RD").document(rdTask.documentID).updateData([
                "status" : rdTask.status + 1])
        }else{
            Firestore.firestore().collection("RD").document(rdTask.documentID).updateData([
                "status" : rdTask.status - 1])
        }
      

    }
    
    
    func configureCell(rdTask:RDTaskInfo) {
        self.rdTask = rdTask
       
        clientNameLabel.text = rdTask.client //顯示客戶名
        taskLabel.text = rdTask.taskTxt      //顯示任務
        let timestap = rdTask.timestamp      //顯示時間
        let levelNumber = rdTask.status
        if levelNumber == 0{
            self.taskStatusView.backgroundColor = UIColor(red: 93/255, green: 205/255, blue: 139/255, alpha: 1)
            self.backGroundView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 0.26)
            self.taskStatusLabel.text = ""
        }else if levelNumber == 1{
            self.taskStatusView.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
            self.backGroundView.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 0.15)
           
            self.taskStatusLabel.text = "處理中"
            self.taskStatusLabel.textColor = .white
      

        }
        
        
//        if staskStatus == true{
//            self.taskStatusView.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
//            self.backGroundView.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 0.15)
//        }else{
//            self.taskStatusView.backgroundColor = UIColor(red: 93/255, green: 205/255, blue: 139/255, alpha: 1)
//            self.backGroundView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 0.26)
//        }
        
        let date = timestap.dateValue()  //時間格式化
        let formatter = DateFormatter()  //時間格式
        formatter.dateFormat = "yyyy/M/d    H:m"
        dateLabel.text = formatter.string(from: date)  //顯示時間
        
        
        
        
    }


    
}
