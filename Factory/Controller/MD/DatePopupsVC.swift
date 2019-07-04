//
//  DatePopupsVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/3.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class DatePopupsVC: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var backGroundView: UIView!
    
    var date:Date!
    
    var formattedDate:String {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy/M/d"
        return formatter.string(from: datePicker.date)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        date =  datePicker.date
        backGroundView.layer.cornerRadius = 8
    }
    
    @IBAction func saveDateButtonPress(_ sender: UIButton) {
       transferInfo()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      transferInfo()
    }
    
    //傳送資料
    func transferInfo(){
        dismiss(animated: true, completion: nil)  //畫面撤掉
        NotificationCenter.default.post(name:.saveDate , object: self)   //post資料
    }
    
}

extension Notification.Name{
    static let saveDate = Notification.Name("saveDate")
}
