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
        dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name:.saveDate , object: self)
    }
    
}

extension Notification.Name{
    static let saveDate = Notification.Name("saveDate")
}
