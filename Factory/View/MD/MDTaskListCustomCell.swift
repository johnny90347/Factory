//
//  MDTaskListCustomCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/3.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MDTaskListCustomCell: UITableViewCell {
    
    var mdTask:MDTaskInfo!
    
    @IBOutlet weak var leftStatusView: UIView!  //左側狀態view
    @IBOutlet weak var leftStatusLabel: UILabel!
    
    @IBOutlet weak var upperRightView: UIView! //右側狀態view
    @IBOutlet weak var upperRightLabel: UILabel!
    
    @IBOutlet weak var backGroundView: UIView! //背景
    
    
    @IBOutlet weak var shipDateLabel: UILabel! //文字
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var numberOfKgLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(levelUpAndDown))
        leftStatusView.addGestureRecognizer(tap)
        leftStatusView.isUserInteractionEnabled = true
    }
    
    @objc func levelUpAndDown(){
        //點一下 狀態等級 = 1   再點一下 = 0
        if mdTask.status == 0 {
            Firestore.firestore().collection("MD").document(mdTask.documentID).updateData([
                "status": mdTask.status + 1])
        }else{
            Firestore.firestore().collection("MD").document(mdTask.documentID).updateData([
                "status": mdTask.status + -1])
        }
        
    }
    
    
    func configureCell(mdTask:MDTaskInfo) {
        self.mdTask = mdTask
        
        clientNameLabel.text = mdTask.client
        productNameLabel.text = mdTask.productName
        numberOfKgLabel.text = mdTask.numberOfKg
        
        
        let date = mdTask.shipDate.dateValue()   //把timestamp 轉 Date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M/d"       //date 格式
        shipDateLabel.text = formatter.string(from: date) //date轉字串＋顯示
        
        //畫面設計
        leftStatusView.layer.cornerRadius = 10
        upperRightView.layer.cornerRadius = 10
        backGroundView.layer.cornerRadius = 10
        if mdTask.status == 0{      //如果在等待中
            self.leftStatusView.backgroundColor = UIColor(red: 93/255, green: 205/255, blue: 139/255, alpha: 1)
            self.backGroundView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 0.26)
 
            self.leftStatusLabel.text = ""
            self.upperRightLabel.text = ""
            self.upperRightView.backgroundColor = .clear
        }else if mdTask.status == 1{ //如果再製造中
            self.leftStatusView.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
            self.backGroundView.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 0.15)
            self.leftStatusLabel.text = "生產中"
            self.leftStatusLabel.textColor = .white
            self.upperRightLabel.text = "\(mdTask.device)"
            self.upperRightView.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 0.5)
 
     
    }



    }
}
